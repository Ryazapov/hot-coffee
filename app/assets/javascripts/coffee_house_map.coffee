class CoffeeHouseMap
  constructor: (@$el) ->
    @_setupMap()
    @_isNewForm()

  _setupMap: =>
    @map = new google.maps.Map(@$el.context, @_mapOptions())
    console.log @$el.context
    @coffee_house = @$el.data
    @_addCoffeeHouseMarker()
    @_addUserMarker()

  _mapOptions: =>
    zoom: 15
    center: @_centerLatLng()

  _addUserMarker: =>
    return unless navigator.geolocation

    navigator.geolocation.getCurrentPosition (position) =>
      userLatLng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude)
      new (google.maps.Marker)(
        position: userLatLng
        map: @map)

$.fn.initCoffeeHouseMap = ->
  return $(@).each ->
    unless $.data(@, "coffee-house__map")
      $.data(@, "coffee-house__map", new Map($(@)))
