# frozen_string_literal: true

module Base
  class Observer

    def update(_subject)
      raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end

  end
end
