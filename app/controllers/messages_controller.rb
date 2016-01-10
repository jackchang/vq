class MessagesController < ApplicationController

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    
    if @message.valid?
      MessageMailer.new_message(@message).deliver
      respond_to do |format|
        format.html {redirect_to root_path, notice: "Your messages has been sent."}
        format.js
      end
    else
      flash[:alert] = "An error occurred while delivering this message."
      respond_to do |format|
        format.html {render "new"}
        format.js
      end
      
    end
  end

private

  def message_params
    params.require(:message).permit(:name, :email, :subject, :content)
  end

end
