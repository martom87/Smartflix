# frozen_string_literal: true

module Base
  class Subject

    def attach(_observer)
      raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end

    def detach(_observer)
      raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end

    def notify
      raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end

  end
end
