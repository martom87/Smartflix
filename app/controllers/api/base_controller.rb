# frozen_string_literal: true

module Api
  class BaseController < ActionController::API

    include Authentication::Helper

  end
end
