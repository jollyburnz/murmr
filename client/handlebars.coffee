
# Check if is admin

# Get current username

# Function to retrieve isAdmin of current user
isAdmin = (user) ->
  if user.profile.isAdmin and user.profile.isAdmin is true
    true
  else
    false
Handlebars.registerHelper "isAdmin", (showError) ->
  user = Meteor.user()
  unless user is `undefined`
    if isAdmin(user)
      true
    else
      false

Handlebars.registerHelper "username", (showError) ->
  if Meteor.user()
    Meteor.user().profile.name
  else
    false

