# frozen_string_literal: true

module SaveFetchedMovie
  class EntryPoint < BaseEntryPoint

    def initialize(params:)
      @inputs = Inputs.new(params: params)
      @action = Action.new(inputs: inputs.params)
    end

  end
end
