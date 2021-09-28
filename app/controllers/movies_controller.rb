# frozen_string_literal: true

class MoviesController < ApplicationController

  prepend_before_action :authenticate!

  def show
    movie = Movie.find_by(title: params[:title])

    if movie

      render json: movie, status: :ok
    else
      CreateMovieWorker.perform_async(params[:title])
      # render json: { message: "The film #{params[:title]} will be downloaded" }, status: :not_found
      render json: { message: $redis.get(:create_movie_worker_response) }, status: :not_found
    end
  end

end
