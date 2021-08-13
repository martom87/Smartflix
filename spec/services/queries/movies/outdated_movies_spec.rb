# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Queries::Movies::OutdatedMovies, type: :query do
  describe '.call' do
    subject { described_class.call(up_to) }

    let(:up_to) { 48.hours.ago }
    let(:movie1) { create(:movie, updated_at: up_to) }
    let(:movie2) { create(:movie, updated_at: up_to - 1.minute) }
    let(:movie3) { create(:movie, updated_at: up_to + 1.minute) }
    let(:movies) { [movie1, movie2, movie3] }

    it 'finds the movies that were updated before a given time period' do
      freeze_time do
        movies

        expect(subject).to eq([movie2])
      end
    end
  end
end
