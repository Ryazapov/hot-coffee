class CoffeeHouseMap
  constructor: (@$el) ->
    @_setupMap()

  _setupMap: =>
    @coffeeHouse = JSON.parse(@$el.context.dataset.coffeeHouse)
    @map = new google.maps.Map(@$el.context, @_mapOptions())
    @_addCoffeeHouseMarker()
    @_addUserMarker()

  _mapOptions: =>
    zoom: 15
    center: @_coffeeHouseLatLng()

  _addUserMarker: =>
    return unless navigator.geolocation

    navigator.geolocation.getCurrentPosition (position) =>
      userLatLng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude)
      new (google.maps.Marker)(
        position: userLatLng
        map: @map)

  _addCoffeeHouseMarker: =>
    new (google.maps.Marker)(
      position: @_coffeeHouseLatLng()
      map: @map)

  _coffeeHouseLatLng: =>
    new google.maps.LatLng(@coffeeHouse.latitude, @coffeeHouse.longitude)

$.fn.initCoffeeHouseMap = ->
  return $(@).each ->
    unless $.data(@, "coffee-house__map")
      $.data(@, "coffee-house__map", new CoffeeHouseMap($(@)))