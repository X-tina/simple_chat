desc "Test task"
task :show_count => :environment do
  User.count_time
end