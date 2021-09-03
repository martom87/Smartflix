# frozen_string_literal: true

module SaveFetchedMovie
  class EntryPoint < BaseEntryPoint

    def initialize(params:, observers:)
      @inputs = Inputs.new(params: params)
      @action = Action.new(inputs: inputs.params)
      observers.each { |o| @action.attach(o) }
    end

  end
end
