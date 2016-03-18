# Be sure to restart your server when you modify this file. Action Cable runs in an EventMachine loop that does not support auto reloading.
class RoomChannel < ApplicationCable::Channel
  def subscribed
      stream_from "room_channel_#{current_user.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Message.create! content: data['message'], user_id: data['sender'], receiver_id: data['receiver']
  end
end
