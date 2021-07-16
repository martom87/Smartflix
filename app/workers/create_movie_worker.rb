# frozen_string_literal: true

class CreateMovieWorker

  include Sidekiq::Worker
  sidekiq_options retry: false, queue: 'movie'

  def perform
    Movie.create(title: 'Star Wars')
  end

end
