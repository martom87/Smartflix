# frozen_string_literal: true

require 'rails_helper'

describe RemoveOutdatedMovies::EntryPoint do
  subject { described_class.new.call }

  let(:up_to) { 48.hours.ago }

  let(:movie1) { create(:movie, updated_at: 72.hours.ago) }
  let(:movie2) { create(:movie, updated_at: 24.hours.ago) }

  it 'removes outdated movies' do
    movie1
    movie2
    expect { subject }.to change(Movie, :count).by(-1)
  end
end
