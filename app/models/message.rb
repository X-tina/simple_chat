class Message < ActiveRecord::Base
  after_create_commit { MessageBroadcastJob.perform_later(self) }
  default_scope { order('created_at DESC') }
end
