# frozen_string_literal: true

class UpdateMovieWorker

  include Sidekiq::Worker
  sidekiq_options queue: :movies, retry: false

  def perform
    UpdateMovies::EntryPoint.call
  end

end
