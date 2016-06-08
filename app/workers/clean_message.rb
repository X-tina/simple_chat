class CleanMessage
  include Sidekiq::Worker
  DAYS_NUM = 2

  def perfom(days_num)
    @messages = Message.where('created_at <= :days', days: days_num.days.ago)
    ids = @messages.ids.map(&:to_json)
    @messages.delete_all
    $redis_likes.del(ids)
  end
end