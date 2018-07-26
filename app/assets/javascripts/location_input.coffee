class LocationInput
  KAZAN_LATITUDE = 55.788258
  KAZAN_LONGITUDE = 49.119290

  constructor: (@$el) ->
    @_setupMap()
    @_bindEvents()
    @_changeCenterCoords()

  _setupMap: =>
    center = new google.maps.LatLng(KAZAN_LATITUDE, KAZAN_LONGITUDE)
    mapOptions =
      zoom: 15
      center: center

    @map = new google.maps.Map(@$el.context, mapOptions)

  _bindEvents: =>
    @map.addListener("click", @_addMarker)

  _addMarker: (event) =>
    if @marker
      @marker.setPosition(event.latLng)
    else
      @marker = new (google.maps.Marker)(
        position: event.latLng
        map: @map)

  _changeCenterCoords: =>
    return unless navigator.geolocation

    navigator.geolocation.getCurrentPosition (position) =>
      center = new google.maps.LatLng(position.coords.latitude, position.coords.longitude)
      @map.setCenter(center)

$.fn.initLocationInput = ->
  return $(@).each ->
    unless $.data(@, "location-input")
      $.data(@, "location-input", new LocationInput($(@)))
