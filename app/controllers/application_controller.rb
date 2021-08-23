# frozen_string_literal: true

class ApplicationController < ActionController::Base
  prepend_before_action :authenticate!
end
