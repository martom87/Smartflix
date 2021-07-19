# frozen_string_literal: true

class MoviesController < ApplicationController

  def show    
    SaveFetchedMovie::EntryPoint.call(params: {title: params[:title]})
    
    render :json => '{foo: }'.to_json
  end

end
