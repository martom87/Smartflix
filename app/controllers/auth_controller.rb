# frozen_string_literal: true

class AuthController < ApplicationController

  def login
    render json: User.find(params[:id]).attributes.slice('token')
  end

end
