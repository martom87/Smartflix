# frozen_string_literal: true

class CreateMovieWorker

  include Sidekiq::Worker
  sidekiq_options retry: false, queue: :movies

  def perform(title)
    SaveFetchedMovie::EntryPoint.call(params: { title: title })
  end

end
