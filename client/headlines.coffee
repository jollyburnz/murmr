getheadlines = (query) ->
  Meteor.call 'getfromNYT', query, (err, res) ->
    #console.log res.data.results #if err is not 'undefined'
    Session.set 'data', res.data.results  if !err

Template.headlines.in_room = ->
  Session.equals "in_room", true

Template.headlines.room_name = ->
  curRoomId = Session.get("current_room")
  curRoom = rooms.findOne(_id: curRoomId)
  unless curRoom is `undefined`
    getheadlines(curRoom.name)
    curRoom.name
  else
    false


Template.headlines.items = ->
  Session.get 'data'