desc "Test task"
task :show_count => :environment do
  User.count_time
end

desc "Remove old messages"
task :clean_messages => environment do
  CleanMessage.perform_async(CleanMessage::DAYS_NUM)
end
