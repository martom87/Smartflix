# frozen_string_literal: true

module UpdateMovies
  class EntryPoint < BaseEntryPoint

    def initialize
      @action = Action.new
    end

  end
end
