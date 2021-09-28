# frozen_string_literal: true

class BaseEntryPoint

  def call
    validate_inputs!
    attach_observers
    action.call
    detach_observers
  end

  def self.call(*args, **kwargs)
    new(*args, **kwargs).call
  end

  private

  attr_accessor :action, :inputs, :observers

  def validate_inputs!
    return unless inputs

    result = inputs.call
    raise ::Errors::ValidationError.new(**result.errors.to_h) if result.failure?
  end

  def attach_observers
    return if observers.blank?

    observers.each { |observer| action.attach(observer) }
  end

  def detach_observers
    return if observers.blank?

    observers.each { |observer| detach(observer) }
  end

end
