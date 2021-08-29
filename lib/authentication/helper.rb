# frozen_string_literal: true

module Authentication
  module Helper
    def authenticate!
      request.env['warden'].authenticate!
    end

    def current_user
      request.env['warden'].user
    end
  end
end
