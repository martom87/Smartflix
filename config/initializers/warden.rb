# frozen_string_literal: true

Warden::Strategies.add(:token, Authentication::TokenStrategy)
