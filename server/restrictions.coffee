
###
Rooms restrictions
Allow everyone to insert a new room
Only admin: update and remove rooms
###

# TODO: Test for admin or current user

# TODO: Test for admin or current user

###
All actions to the users collection needs admin access
###

###
function to check for admin access
###
onlyIfAdmin = (userId) ->
  isAdmin = isAdminById(userId)
  return true  if isAdmin
  false

###
Check for admin access by id
###
isAdminById = (userId) ->
  user = Meteor.users.findOne(_id: userId)
  return true  if user and user.profile.isAdmin
  false
Meteor.startup ->
  rooms.allow
    insert: (userId, doc) ->
      true

    update: (userId, docs, fields, modifier) ->
      true

    remove: (userId, docs) ->
      onlyIfAdmin userId

  Meteor.users.allow
    remove: (userId, docs) ->
      onlyIfAdmin userId

    update: (userId, docs, fields, modifier) ->
      onlyIfAdmin userId

    insert: (userId, docs) ->
      onlyIfAdmin userId


