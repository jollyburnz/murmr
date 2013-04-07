###
@blob (https://developer.mozilla.org/en-US/docs/DOM/Blob)
@name the file's name
@type the file's type: binary, text (https://developer.mozilla.org/en-US/docs/DOM/FileReader#Methods)

TODO Support other encodings: https://developer.mozilla.org/en-US/docs/DOM/FileReader#Methods
ArrayBuffer / DataURL (base64)
###
Meteor.saveFile = (blob, name, path, type, callback) ->
  fileReader = new FileReader()
  method = undefined
  encoding = "binary"
  type = type or "binary"
  switch type
    when "text"

      # TODO Is this needed? If we're uploading content from file, yes, but if it's from an input/textarea I think not...
      method = "readAsText"
      encoding = "utf8"
    when "binary"
      method = "readAsBinaryString"
      encoding = "binary"
    else
      method = "readAsBinaryString"
      encoding = "binary"
  fileReader.onload = (file) ->
    Meteor.call "saveFile", file.srcElement.result, name, path, encoding, callback

  fileReader[method] blob
