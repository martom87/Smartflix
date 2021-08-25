# frozen_string_literal: true

require 'warden'

module Authentication
  class TokenStrategy < Warden::Strategies::Base

    def valid?
      access_token.present?
    end

    def authenticate!
      user = User.find_by_token(access_token)

      if user.nil?
        fail!('Could not log in')
      else
        user.regenerate_token
        success!(user)
      end
    end

    private

    def access_token
      @access_token ||= request.get_header('access_token')
    end

  end
end
