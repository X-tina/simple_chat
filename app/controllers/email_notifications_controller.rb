class EmailNotificationsController < ApplicationController
  acts_as_token_authentication_handler_for User, only: :none

  EMAIL_REGEXP = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  def send_email
    @mail = DefaultMailer.notification_email(email_notif_params)

    if @mail.deliver
      respond_to do |format|
        format.json { render text: "{ Email was sent successfulley }" }
      end
    else
      respond_to do |format|
        format.json { render text: "{ Email wasn't sent }" }
      end
    end
  end

  private
    def email_notif_params
      params.require(:user).permit(:start_time, :end_time, :date, :name, :phone, :email)
    end
end
