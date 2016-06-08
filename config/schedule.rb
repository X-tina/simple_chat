# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever






#  bundle exec whenever

# To clear your crontab, run the following command:
# $ whenever -c

# Set development env for cron
# bundle exec whenever --set 'environment=development' -w

# Write new job into crontab
# whenever -w

# Check crontab
# crontab -e

# allow you to use a different schedule file
# $ whenever -f /path/to/schedule/file/myschedule.rb

set :environment, "development"
set :output, {:error => "log/cron_error_log.log", :standard => "log/cron_log.log"}

# every 2.minutes do
#   rake 'show_count'
# end

every 2.minutes do
  runner "Message.remove_old"
end
