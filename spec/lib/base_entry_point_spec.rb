# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ::BaseEntryPoint do
  subject(:entry_point) { fake_entry_point_class }

  let(:fake_inputs_class) do
    Class.new(::Inputs) do
      json do
        required(:some_field).filled(:integer, gt?: 0)
      end
    end
  end
  let(:fake_entry_point_class) do
    Class.new(::BaseEntryPoint) do
      def initialize(action:, params:)
        self.action = action
        self.inputs = ::FakeInputs.new(params: params)
      end
    end
  end
  let(:action) { double('action') } # rubocop:disable RSpec/VerifiedDoubles

  before { stub_const('::FakeInputs', fake_inputs_class) }

  context 'when EntryPoint is called with valid input' do
    it 'calls action' do
      expect(action).to receive(:call)

      entry_point.call(action: action, params: { some_field: 5 })
    end
  end

  context 'when EntryPoint is called with invalid input' do
    it 'raises ValidationError and does not call action', :aggregate_failures do
      expect(action).not_to receive(:call)

      expect { entry_point.call(action: action, params: { some_field: -1 }) }.to raise_error ::Errors::ValidationError
    end
  end

  context 'when EntryPoint is called with not allowed input' do
    it 'raises ValidationError and does not call action', :aggregate_failures do
      expect(action).not_to receive(:call)

      expect do
        entry_point.call(action: action, params: { name: 'foo', not_allowed: 'bar' })
      end.to raise_error ::Errors::ValidationError, /is not allowed/
    end
  end
end
