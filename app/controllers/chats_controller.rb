
class ChatsController < ApplicationController
  before_action :set_chat, only: [:show, :edit, :update]
  before_action :authenticate_user!
  load_and_authorize_resource
  def index
    @chats = Chat.all
  end

  def show
    @chat = Chat.find(params[:id])
  end

  def new
    @chat = Chat.new
  end

  def create
    @chat = Chat.new(chat_params)
    unless [@chat.sender_id, @chat.receiver_id].include?(current_user.id)
      redirect_to chats_path, alert: "Only can create chats where you are a participant"
      return
    end
    if @chat.save
      redirect_to @chat, notice: "Chat creado exitosamente"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @chat.update(chat_params)
      redirect_to @chat, notice: "Chat updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end


  private
  def set_chat
    @chat = Chat.find(params[:id])
  end

  def chat_params
    params.require(:chat).permit(:sender_id, :receiver_id)
  end
end