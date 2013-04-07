Meteor.startup ->
  #LOCALHOST
  Accounts.loginServiceConfiguration.remove service: "twitter"
  Accounts.loginServiceConfiguration.insert
    service: "twitter"
    consumerKey: "XldkM0IIh16xrvHBZd6BQ"
    secret: "y1z6hvLRRuRdm4y9CckOnrDco3cOTtPBDILKiTBbYNI"

  Accounts.loginServiceConfiguration.remove service: "facebook"
  Accounts.loginServiceConfiguration.insert
    service: "facebook"
    appId: "577242132294795"
    secret: "9d8466a093d78edfa29542f3e25aa23d"
  ###
  #MURMR.METEOR.COM
  Accounts.loginServiceConfiguration.remove service: "twitter"
  Accounts.loginServiceConfiguration.insert
    service: "twitter"
    consumerKey: "sFaXYdbCDAqkjUkURsCMg"
    secret: "0BHQ7QLUsEHB8KKsIan0JYhE7POvLlGTjIyKFenue4"

  Accounts.loginServiceConfiguration.remove service: "facebook"
  Accounts.loginServiceConfiguration.insert
    service: "facebook"
    appId: "178620538954607"
    secret: "8eeeac367332968c09b64441129bc704"
  ###

