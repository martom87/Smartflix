# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RemoveOutdatedMoviesWorker do
  describe '#perform' do
    subject { described_class.new.perform }

    let(:outdated_movies) { instance_double('ActiveRecord::Relation') }

    it 'destroys outdated movies' do
      allow(Queries::Movies::OutdatedMovies).to receive(:call).and_return(outdated_movies)
      expect(outdated_movies).to receive(:destroy_all)
      subject
    end
  end
end
