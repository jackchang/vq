class MessageMailer < ActionMailer::Base
  default to: "infinitelunchpail@gmail.com"

  def new_message(message)
    @message = message
    mail from: message.email
    mail subject: message.subject
  end

end
