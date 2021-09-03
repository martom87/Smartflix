# frozen_string_literal: true

module Movies
  class CreateMovieObserver < Base::Observer

    def update(subject)
      return if subject.message.blank?

      Rails.cache.write('create_message', subject.message)
    end

  end
end
