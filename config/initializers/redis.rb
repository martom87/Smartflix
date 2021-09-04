# frozen_string_literal: true

$redis = Redis::Namespace.new('smartflix', redis: Redis.new)
