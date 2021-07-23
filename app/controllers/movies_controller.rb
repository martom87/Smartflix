# frozen_string_literal: true

class MoviesController < ApplicationController

  def show
    render json: "{ message: #{SaveFetchedMovie::EntryPoint.call(params: { title: params[:title] })} rspe}".to_json
  end

end
