class Message < ActiveRecord::Base
  after_create_commit { MessageBroadcastJob.perform_later(self) }
  default_scope { order('created_at DESC') }

  DAYS_NUM = 2
  BATCH_SIZE = 1

  def self.remove_old
    where("created_at <= ?", DAYS_NUM).find_each(batch_size: BATCH_SIZE) do |msg|
      msg.destroy
    end
  end
end
