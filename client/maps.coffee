# jQuery googleMap Copyright Dylan Verheul <dylan@dyve.net>
# * Licensed like jQuery, see http://docs.jquery.com/License
#
$.googleMap =
  maps: {}
  marker: (m) ->
    unless m
      null
    else if not m.lat? and not m.lng?
      $.googleMap.marker $.googleMap.readFromGeo(m)
    else
      marker = new GMarker(new GLatLng(m.lat, m.lng))
      if m.txt
        GEvent.addListener marker, "click", ->
          marker.openInfoWindowHtml m.txt

      marker

  readFromGeo: (elem) ->
    latElem = $(".latitude", elem)[0]
    lngElem = $(".longitude", elem)[0]
    if latElem and lngElem
      lat: parseFloat($(latElem).attr("title"))
      lng: parseFloat($(lngElem).attr("title"))
      txt: $(elem).attr("title")
    else
      null

  mapNum: 1

$.fn.googleMap = (lat, lng, zoom, options) ->

  # If we aren't supported, we're done
  return this  if not window.GBrowserIsCompatible or not GBrowserIsCompatible()

  # Default values make for easy debugging
  lat = 37.4419  unless lat?
  lng = -122.1419  unless lng?
  zoom = 13  unless zoom

  # Sanitize options
  options = {}  if not options or typeof options isnt "object"
  options.mapOptions = options.mapOptions or {}
  options.markers = options.markers or []
  options.controls = options.controls or {}

  # Map all our elements
  @each ->

    # Make sure we have a valid id
    @id = "gMap" + $.googleMap.mapNum++  unless @id

    # Create a map and a shortcut to it at the same time
    map = $.googleMap.maps[@id] = new GMap2(this, options.mapOptions)

    # Center and zoom the map
    map.setCenter new GLatLng(lat, lng), zoom

    # Add controls to our map
    i = 0

    while i < options.controls.length
      c = options.controls[i]
      eval_ "map.addControl(new " + c + "());"
      i++

    # If we have markers, put them on the map
    marker = null
    i = 0

    while i < options.markers.length
      map.addOverlay marker  if marker = $.googleMap.marker(options.markers[i])
      i++

