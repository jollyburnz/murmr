
#===================================
# MESSAGES CONTROLLER
#===================================

###
Autorun
Check for changes on the messages publish
###

###
Room name
Return the current room name if any
###

# Get currentRoom id from session

# Find current room

# If has no room return nothing, else return room name

###
In Room?
Returns true if user is currently in an room
###

###
Messages
Return all messages to the view
###

# Get current room

# if curRoom is defined return messages

###
Current User
Return the current user
###

###
Rendered
Called after the messages template has rendered
###

# Get current geolocation position

# Calculate message list height

# Message list object

# Get the cursor to the current room

# Observe changes to current room

###
GeoLocation
Handle geolocation, is called from the rendered function
###
handle_geolocation_query = (pos) ->

  # Get positions and dump them into this awesome object
  position =
    lat: pos.coords.latitude
    long: pos.coords.longitude


  # Add the geolocation data to the current user
  curUser = Meteor.users.update(
    _id: Meteor.userId
  ,
    $set:
      "profile.geo.lat": position.lat
      "profile.geo.long": position.long
  )

###
View geolocation
Return geolocation for author of message
###

# Get geolocaton of current author

# Return true if author has geolocation, else false

###
Latitude
Return the latitude value to the view
###

# Get current author latitude position

###
Longitude
Return the longitude to the view
###

# Get current author longitude position

###
Get Author
Get the current username, of anonymous is none is given
###
getAuthor = ->
  username = (if (Meteor.user()) then Meteor.user().profile.name else "Anonymous")
  username

###
Key Up Event Handler
Test for an 'enter' on the message input field, and add to collection
###
keyUpMessage = (e, t) ->
  if e.which is 13

    # Get the input value
    messageVal = e.target.value

    # Add message to room collection
    author = rooms.update(
      _id: Session.get("current_room")
    ,
      $addToSet:
        messages:
          message: messageVal
          author: getAuthor()
    )

    # Set value to empty string
    e.target.value = ""

###
Give Karma
Give clicked message author +1 karma
###
giveKarma = (e, t) ->
  author = @author

  # Get all users
  user = Meteor.users.find({}).fetch()

  # Loop through users
  i = 0

  while i < user.length

    # If current user is same as the author
    if user[i].profile.name is author

      # Get current id
      thisId = user[i]._id

      # Call addKarma method on the server
      Meteor.call "addKarma", thisId, Meteor.userId(), (err, res) ->

        # If all goes well change heart icon
        e.target.className = "icon-heart hearted"  if res is true

    i++

###
TODO ==================
File Upload
Handle file upload
###
fileUpload = (e, t) ->

  # Loop through all files selected by input field
  _.each e.srcElement.files, (file) ->
    Meteor.saveFile file, file.name


###
Map Open
Create google map instance on click
###
mapOpen = (e, t) ->

  # Find #map element
  target = $(e.target).find("#map")

  # Toggle visibility
  target.toggle()

  # Get data attributes of lat and long
  lat = target.data("lat")
  longi = target.data("long")

  # Add the googlemaps in #map element
  target.googleMap lat, longi, 15
files = new Meteor.Collection("files")
Meteor.autorun ->
  Meteor.subscribe "messages", Session.get("current_room")

Template.messages.events
  "keyup #message-text": keyUpMessage
  "click .icon-heart-empty": giveKarma
  "click .icon-map-marker": mapOpen
  "change #file-upload": fileUpload

Template.messages.room_name = ->
  curRoomId = Session.get("current_room")
  curRoom = rooms.findOne(_id: curRoomId)
  unless curRoom is `undefined`
    curRoom.name
  else
    false

Template.messages.in_room = ->
  Session.equals "in_room", true

Template.messages.messages = ->
  curRoom = rooms.findOne(_id: Session.get("current_room"))
  unless curRoom is `undefined`
    curRoom.messages
  else
    false

Template.messages.user = ->
  @author

Template.messages.rendered = ->
  pos = navigator.geolocation.getCurrentPosition(handle_geolocation_query)
  calcMessageListHeight()
  messageList = $(".message-list")
  query = rooms.find(_id: Session.get("current_room"))
  handle = query.observeChanges(added: (id, user) ->
    messageListHeight = messageList.height()
    messageList.animate
      scrollTop: messageListHeight
    , 0
  )

Template.messages.geoLocation = ->
  author = @author
  user = Meteor.users.findOne("profile.name": author)
  if user isnt `undefined` and user.profile.geo.lat? and user.profile.geo.long?
    true
  else
    false

Template.messages.lat = ->
  author = @author
  user = Meteor.users.findOne("profile.name": author)
  geoLat = user.profile.geo.lat
  geoLat

Template.messages.long = ->
  author = @author
  user = Meteor.users.findOne("profile.name": author)
  geoLong = user.profile.geo.long
  geoLong


###
Resize event
Calculate message list height on resize
###
$(document).ready ->
  $(window).resize (e) ->
    calcMessageListHeight()

  calcMessageListHeight()

