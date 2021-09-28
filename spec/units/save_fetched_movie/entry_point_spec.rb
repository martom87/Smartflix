# frozen_string_literal: true

require 'rails_helper'

describe SaveFetchedMovie::EntryPoint do
  subject { described_class.call(params: params, observers: observers) }

  let(:params) { { title: 'Star Wars' } }
  let(:observers) { [::Movies::CreateMovieObserver.new] }

  context 'when title is string' do
    it 'gets response' do
      VCR.use_cassette('correct_movie_example', match_requests_on: %i[host method body]) do
        expect { subject }.to change(Movie, :count).by(1)
      end
    end
  end

  context 'when title is string but movie cannot be found' do
    let(:params) { { title: 'film_that_not_exist' } }

    it 'prints error message' do
      VCR.use_cassette('movie_cannot_be_found_example', match_requests_on: %i[host method body]) do
        expect { subject }.to change(Movie, :count).by(0)
      end
    end

    it 'logs a warning' do
      travel_to Time.utc(2021, 8, 2, 11, 44)
      expect(Rails.logger).to receive('warn').with("2021-08-02 11:44:00 UTC: #{params[:title]} movie not found!")
      subject
    end
  end

  context 'when title is invalid' do
    let(:params) { { title: 1 } }

    it 'raises an error' do
      expect { subject }.to raise_error(Errors::ValidationError, '{:title=>["must be a string"]}')
    end
  end

  context 'when params are not given' do
    let(:params) { nil }

    it 'raises an error' do
      expect { subject }.to raise_error NoMethodError
    end
  end
end
