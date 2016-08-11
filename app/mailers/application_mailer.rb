class ApplicationMailer < ActionMailer::Base
  default from: ENV["SOURCE_MAIL"]
end

