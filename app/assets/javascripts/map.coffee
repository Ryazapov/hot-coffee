class Map
  zoom =
    initialView: 15
    closeView: 18
  KAZAN_LATITUDE = 55.788258
  KAZAN_LONGITUDE = 49.119290
  map = undefined

  constructor: (@$el) ->
    @_setupMap()
    @_changeCenterCoords()

  _setupMap: ->
    center = new google.maps.LatLng(KAZAN_LATITUDE, KAZAN_LONGITUDE)
    mapOptions =
      zoom: zoom.initialView
      center: center

    map = new google.maps.Map(@$el.context, mapOptions)

  _changeCenterCoords: ->
    return unless navigator.geolocation

    navigator.geolocation.getCurrentPosition (position) ->
      center = new google.maps.LatLng(position.coords.latitude, position.coords.longitude)
      map.setCenter(center)

  _createMap: (latitude, longitude) ->

$.fn.initMap = ->
  return $(@).each ->
    unless $.data(@, "map")
      $.data(@, "map", new Map($(@)))
