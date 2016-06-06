class Actions::Like
  def call(object, parameter)
    case parameter
      when "+" 
        $redis_likes.incr(object.id)
      when "-" 
        $redis_likes.decr(object.id)
      end
  end

  def get_likes(object)
    count = $redis_likes.get(object.id)
    count.nil? ? 0 : count
  end
end