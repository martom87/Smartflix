#  frozen_string_literal: true

module OmdbApi
  class Base

    include HTTParty
    omdb_api_key = Rails.application.credentials.omdb[:access_key_id]
    base_uri "http://www.omdbapi.com/?apikey=#{omdb_api_key}"

  end
end
