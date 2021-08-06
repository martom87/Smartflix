# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Queries::Movies::OutdatedMovies, type: :query do
  describe '.call' do
    subject { described_class.call(up_to) }

    let(:up_to) { 48.hours.ago }
    let(:movie_1) { create(:movie, updated_at: up_to) }
    let(:movie_2) { create(:movie, updated_at: up_to - 1.minute) }
    let(:movie_3) { create(:movie, updated_at: up_to + 1.minute) }
    let(:movies) { [movie_1, movie_2, movie_3] }

    it 'finds the movies that were updated before a given time period' do
      freeze_time do
        movies

        expect(subject).to eq([movie_2])
      end
    end
  end
end
