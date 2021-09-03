# frozen_string_literal: true

class CreateMovieWorker

  include Sidekiq::Worker
  sidekiq_options retry: false, queue: :movies

  def perform(title)
    movie_create_observer = ::Movies::CreateMovieObserver.new
    SaveFetchedMovie::EntryPoint.call(params: { title: title }, observers: { observer: movie_create_observer })
  end

end
