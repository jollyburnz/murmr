#===================================
# LOGIN CONTROLLER
#===================================

###
Logged In
Return true if current user is logged in
###

###
Twitter Login
Handle twitter login system
###
twitterLogin = (e, t) ->
  e.preventDefault()
  Meteor.loginWithTwitter (error) ->
    return console.log(error)  if error
    Session.set "logged_in", true


###
Facebook login
Handle facebook login system
###
facebookLogin = (e, t) ->
  e.preventDefault()
  Meteor.loginWithFacebook (error) ->
    return console.log(error)  if error
    Session.set "logged_in", true

Session.set "logged_in", false
Session.set "login", true
Template.login.events
  "click #twitter": twitterLogin
  "click #facebook": facebookLogin

Template.login.isLoggedIn = ->
  Meteor.userId()?
