class LocationInput
  KAZAN_LATITUDE = 55.788258
  KAZAN_LONGITUDE = 49.119290

  LATITUDE_INPUT_SELECTOR = "#coffee_house_latitude"
  LONGITUDE_INPUT_SELECTOR = "#coffee_house_longitude"

  constructor: (@$el) ->
    @latitude_input = $(LATITUDE_INPUT_SELECTOR)
    @longitude_input = $(LONGITUDE_INPUT_SELECTOR)

    @_setupMap()
    @_isNewForm()

  _setupMap: =>
    @map = new google.maps.Map(@$el.context, @_mapOptions())
    @map.addListener("click", @_addMarker)
    @_addCurrentMarker()
    @_changeCenterCoords()

  _mapOptions: =>
    zoom: 15
    center: @_centerLatLng()

  _addMarker: (event) =>
    @latitude_input.val(event.latLng.lat)
    @longitude_input.val(event.latLng.lng)

    if @marker
      @marker.setPosition(event.latLng)
    else
      @marker = new (google.maps.Marker)(
        position: event.latLng
        map: @map)

  _addCurrentMarker: =>
    return if @_isNewForm()

    @marker = new (google.maps.Marker)(
      position: new google.maps.LatLng(@latitude_input.val(), @longitude_input.val())
      map: @map)

  _changeCenterCoords: =>
    return unless navigator.geolocation

    navigator.geolocation.getCurrentPosition (position) =>
      center = new google.maps.LatLng(position.coords.latitude, position.coords.longitude)
      @map.setCenter(center) if @_isNewForm()

  _centerLatLng: =>
    return new google.maps.LatLng(KAZAN_LATITUDE, KAZAN_LONGITUDE) if @_isNewForm()

    new google.maps.LatLng(@latitude_input.val(), @longitude_input.val())

  _isNewForm: =>
    @latitude_input.val().length == 0 && @longitude_input.val().length == 0

$.fn.initLocationInput = ->
  return $(@).each ->
    unless $.data(@, "location-input")
      $.data(@, "location-input", new LocationInput($(@)))
