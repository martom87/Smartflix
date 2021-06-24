# frozen_string_literal: true

module Errors
  class ArgumentError < StandardError

    def initialize(message = nil)
      @message = message
    end

    attr_reader :message

  end
end
