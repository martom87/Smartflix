# frozen_string_literal: true

class BaseEntryPoint

  def call
    validate_inputs!
    action.call
  end

  def self.call(*args, **kwargs)
    new(*args, **kwargs).call
  end

  private

  attr_accessor :action, :inputs

  def validate_inputs!
    return unless inputs

    result = inputs.call
    raise ::Errors::ValidationError.new(**result.errors.to_h) if result.failure?
  end

end
