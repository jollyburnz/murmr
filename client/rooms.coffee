
#===================================
#  ROOMS CONTROLLER
#===================================

###
All rooms
Return all rooms
###

###
Add room
Return true if add_room is active
###

###
Current room
Return true if current item is the current room
###

###
Show Room Name Field
Shows the input field to create a room
###
showRoomNameField = (e, t) ->
  focusText $("#room-name")
  Session.set "add_room", true
focusText = (i) ->
  i.focus()
  i.select()

###
Create Room
Logic for creating a room
###
addRoom = (e, t) ->
  if e.which is 13
    roomValue = e.target.value
    rooms.insert name: roomValue
    Session.set "add_room", false

###
Click Room
Route to the room id
###
clickRoom = (e, t) ->
  roomId = e.target.id
  Meteor.Router.to "/room/" + roomId
  Session.set "current_room", roomId

###
List Height
Calculate the height of the messages list
###
calcMessageListHeight = ->
  messageList = $(".message-list")
  docHeight = $(window).height() - 204
  messageList.height docHeight
rooms = new Meteor.Collection("rooms")
Meteor.subscribe "rooms"
Template.rooms.events
  "click #add-name": showRoomNameField
  "keyup #room-name": addRoom
  "click .rooms-list li": clickRoom

Template.rooms.rooms = ->
  rooms.find {},
    sort:
      name: 1


Template.rooms.add_room = ->
  Session.equals "add_room", true

Template.rooms.isCurrentRoom = ->
  roomLinkId = @_id
  selectedRoomId = Session.get("current_room")
  if roomLinkId is selectedRoomId
    true
  else
    false
