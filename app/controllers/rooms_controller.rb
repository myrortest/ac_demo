class RoomsController < ApplicationController

  before_filter :authenticate_user
  before_filter :load_sender, only:[:show, :start_chat]
  before_filter :load_receiver, only:[:start_chat]

  def show
    @users = User.all.where.not(id: current_user.id)
  end

  def start_chat
    @messages = Message.all.where(user_id: [@sender.id, @receiver.id], receiver_id: [@sender.id, @receiver.id])
  end

  private

  def load_sender
    @sender = current_user
  end

  def load_receiver
    @receiver = User.find_by(id: params[:id])
    unless @receiver
      redirect_to :root_path   
    end
  end

end
