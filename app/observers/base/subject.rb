# frozen_string_literal: true

module Base
  module Subject
    def initialize(_observers)
      @observers = []
    end

    def attach(observer)
      @observers << observer
    end

    def detach(observer)
      @observers.delete(observer)
    end

    private

    def notify
      raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end
  end
end
