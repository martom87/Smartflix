# frozen_string_literal: true

class MoviesController < ApplicationController

  def show
    movie = Movie.find_by(title: params[:title])

    if movie

      render json: movie, status: :ok
    else
      CreateMovieWorker.perform_async(params)
      render json: { message: "The film #{params[:title]} will be downloaded" }, status: :not_found
    end
  end

end
