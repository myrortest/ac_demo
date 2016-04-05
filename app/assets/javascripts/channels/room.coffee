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

    # inserting reciever name's first character
    data['message'] = data['message'].replace('<span class="bubble_user_icon hide">', '<span class="bubble_user_icon">'+$('#receiver_name').html()[0]);

    if $("#user_"+sender_id).length == 1
      $('#user_'+sender_id).append data['message'].replace('<span class="bubble_user_icon hide">','<span class="bubble_user_icon">')
    else
      $('#noti_'+sender_id).removeClass('hide')
      if $('#noti_' + sender_id).html() == ""
        $('#noti_'+sender_id).html("1")
      else
        $('#noti_'+sender_id).html(parseInt($('#noti_'+sender_id).html()) + 1)

    if $('#msg_sender_id').html() == sender_id
      data['message'] = data['message'].replace('"message"','"message pull-right"');

    $('#user_'+receiver_id).append data['message'].replace('<span class="bubble_user_icon">','<span class="bubble_user_icon hide">').replace('btm-left-in','btm-right-in')

    # Called when there's incoming data on the websocket for this channel
    scrollItNow()

  speak: (message, sender, receiver) ->
    @perform 'speak', message: message, sender: sender, receiver: receiver

$(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
  if event.keyCode is 13 #return = send
    if event.target.value != "" && event.target.value != "\n"     # To checking if user is not sending blank chat.
      App.room.speak(event.target.value, event.target.parentElement.children.sender.value, event.target.parentElement.children.receiver.value)
      event.target.value = ''
      event.preventDefault()
    else
      event.preventDefault()

