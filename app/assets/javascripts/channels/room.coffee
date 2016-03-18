App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->

    message = a(data['message'].match(">(.*)</")[1],data['message'])
    data['message'] = message
    

    # Getting sender and receiver id from message to append message only sender and receiver chat window. 
    sender_id = $($.parseHTML(data['message'])).find("#sender_id").html()
    receiver_id = $($.parseHTML(data['message'])).find("#receiver_id").html()

    if $("#user_"+sender_id).length == 1
      $('#user_'+sender_id).append data['message']
    else
      $('#noti_'+sender_id).removeClass('hide')
      if $('#noti_' + sender_id).html() == " "
        $('#noti_'+sender_id).html("1")
      else
        $('#noti_'+sender_id).html(parseInt($('#noti_'+sender_id).html()) + 1)

    $('#user_'+receiver_id).append data['message']

    # Called when there's incoming data on the websocket for this channel
    scrollItNow()

  speak: (message, sender, receiver) ->
    @perform 'speak', message: message, sender: sender, receiver: receiver

$(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
  if event.keyCode is 13 #return = send
    App.room.speak(event.target.value, event.target.parentElement.children.sender.value, event.target.parentElement.children.receiver.value)
    event.target.value = ''
    event.preventDefault()

