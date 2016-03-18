class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast 'room_channel_'+message[:user_id].to_s, message: render_message(message)
    ActionCable.server.broadcast 'room_channel_'+message[:receiver_id].to_s, message: render_message(message)
  end

  private

  def render_message(message)
    current_user = User.find_by(id: message.user_id)
    ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message, current_user: current_user })
  end

end
