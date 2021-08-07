# frozen_string_literal: true

module RemoveOutdatedMovies
  class EntryPoint < BaseEntryPoint

    def initialize
      @action = Action.new
    end

  end
end
