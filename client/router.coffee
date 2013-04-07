
# Get room by given id
# TODO: Use room name instead of id
Meteor.Router.add "/room/:id": (id) ->
  Session.set "current_room", id
  Session.set "in_room", true
  "messages"

