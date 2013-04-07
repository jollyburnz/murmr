Meteor.startup ->
  require = __meteor_bootstrap__.require
  Future = require("fibers/future")
  Meteor.methods

    ###
    Add Karma
    Add karma to given userId
    ###
    addKarma: (id, userId) ->
      return false  if id is userId
      current = Meteor.users.findOne(_id: id)
      karma = current.profile.karma
      karmaGiven = current.profile.karmaGiven
      if _.contains(karmaGiven, userId)
        false
      else
        update = Meteor.users.update(
          _id: id
        ,
          $set:
            "profile.karma": karma + 1

          $addToSet:
            "profile.karmaGiven": userId
        )
        true


    ###
    Save File to Server
    Add given file to the server with nodes filesystem
    ###
    saveFile: (blob, name, path, encoding) ->

      # Clean up the path. Remove any initial and final '/' -we prefix them-,
      # any sort of attempt to go to the parent directory '..' and any empty directories in
      # between '/////' - which may happen after removing '..'

      # TODO Add file existance checks, etc...
      cleanPath = (str) ->
        str.replace(/\.\./g, "").replace(/\/+/g, "").replace(/^\/+/, "").replace /\/+$/, ""  if str
      cleanName = (str) ->
        str.replace(/\.\./g, "").replace /\//g, ""
      path = cleanPath(path)
      fs = __meteor_bootstrap__.require("fs")
      name = cleanName(name or "file")
      encoding = encoding or "binary"
      chroot = Meteor.chroot or "public"
      path = chroot + ((if path then "/" + path + "/" else "/"))
      fs.writeFile path + name, blob, encoding, (err) ->
        if err
          throw (new Meteor.Error(500, "Failed to save file.", err))
        else
          console.log "The file " + name + " (" + encoding + ") was saved to " + path

    getfromNYT: (query) ->
      url = "http://api.nytimes.com/svc/search/v1/article?query=" + query + "&facets=des_facet,per_facet,geo_facet,classifiers_facet,org_facet&api-key=56b3f37b47949deae87a123c880d0dde:10:61396"
      fut = new Future()
      Meteor.http.get url, (err, result) ->
        fut.ret result
      console.log fut.wait(), 'yooo'
      fut.wait()



