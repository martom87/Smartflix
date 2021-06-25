# frozen_string_literal: true

module SaveFetchedMovie
  class Inputs < ::Inputs

    json do
      required(:title).filled(:string)
    end

  end
end
