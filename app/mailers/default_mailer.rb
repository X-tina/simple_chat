class DefaultMailer < ApplicationMailer
  RECIPIENT_MAIL = ENV['RECIPIENT_MAIL']
  
  def notification_email(params_options, email=RECIPIENT_MAIL)
    params_options.to_h.map {|k,v| instance_variable_set("@#{k}", v)}

    mail(to: email, subject: "Booking the date", )
  end
end
