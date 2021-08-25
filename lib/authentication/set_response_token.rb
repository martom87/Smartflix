# frozen_string_literal: true

module Authentication
  class SetResponseToken

    def initialize(app)
      @app = app
    end

    def call(env)
      res = @app.call(env)
      res[1]['Access-Token'] = env['warden'].user.token if res[0] < 300 && !skipp_request(env)
      res
    end

    private

    def skipp_request(env)
      env['REQUEST_URI'] =~ /\/login$/
    end

  end
end
