# frozen_string_literal: true

class CreateMovieWorker

  include Sidekiq::Worker
  sidekiq_options retry: false, queue: 'movie'

  def perform(params)
    SaveFetchedMovie::EntryPoint.call(params: { title: params[:title] })
  end

end
