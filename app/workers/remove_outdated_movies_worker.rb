# frozen_string_literal: true

class RemoveOutdatedMoviesWorker

  include Sidekiq::Worker
  sidekiq_options queue: :movies, retry: false

  def perform
    RemoveOutdatedMovies::EntryPoint.call
  end

end
