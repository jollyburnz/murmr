Template.controls.events "click #logout": (e, t) ->
  e.preventDefault()

  # Logout current user
  Meteor.logout (err) ->
    console.log err  if err



###
Check if user is logged in
###
Template.controls.isLoggedIn = ->
  Meteor.userId()?
