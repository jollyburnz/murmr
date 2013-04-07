#===================================
# USER MODEL
#===================================
Accounts.onCreateUser (options, user) ->

  # Add a few fields to the user
  user.profile = options.profile or {}
  user.profile.karma = 0
  user.profile.karmaGiven = []
  user.profile.geo =
    lat: null
    long: null


  # Check if email is given
  user.profile.email = options.email  if options.email

  # Check if profile name is given, else use username
  user.profile.name = user.username  unless user.profile.name

  # If user profile name is Wiljan Slofstra, make admin !!!
  user.profile.isAdmin = true  if user.profile.name is "Wiljan Slofstra"

  # Return the user, why not?
  user

