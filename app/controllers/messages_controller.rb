class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @messages = Message.all
  end



  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    chat = Chat.find(@message.chat_id)
    unless [chat.sender_id, chat.receiver_id].include?(current_user.id)
      redirect_to messages_path, alert: "Only can create messages in chats where you are a participant"
      return
    end
    @message.user_id = current_user.id

    if @message.save
      redirect_to @message, notice: 'Message sent successfully.'
    else
      render :new
    end
  end

  def update
    if @message.update(message_params)
      redirect_to @message, notice: 'Message updated successfully.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @message.destroy
    authorize! :destroy, @message
    if @message.destroy
      redirect_to messages_path, notice: 'Message deleted successfully.'
    else
      redirect_to messages_path, alert: 'Failed to delete message.'
    end
  end
  private

  def set_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:chat_id, :user_id, :body)
  end
end