rooms = new Meteor.Collection("rooms")
files = new Meteor.Collection("files")

###
Publish the rooms collection
###
Meteor.publish "rooms", ->
  rooms.find {}


###
Publish the rooms.messages collection
###
Meteor.publish "messages", (room_id) ->
  rooms.find _id: room_id

