class LocationInput {
  static initClass() {
    KAZAN_LATITUDE = 55.788258;
    KAZAN_LONGITUDE = 49.119290;

    LATITUDE_INPUT_SELECTOR = "#coffee_house_latitude";
    LONGITUDE_INPUT_SELECTOR = "#coffee_house_longitude";
  }

  constructor($el) {
    this.$el = $el;
    this.latitudeinput = $(LATITUDE_INPUT_SELECTOR);
    this.longitudeinput = $(LONGITUDE_INPUT_SELECTOR);

    this.setupMap();
    this.isNewForm();
  }

  setupMap() {
    this.map = new google.maps.Map(this.$el.context, this.mapOptions());
    this.map.addListener("click", this.addMarker);
    this.addCurrentMarker();
    this.changeCenterCoords();
  }

  mapOptions() {
    return {
      zoom: 15,
      center: this.centerLatLng(),
    };
  }

  addMarker(event) {
    this.latitudeinput.val(event.latLng.lat);
    this.longitudeinput.val(event.latLng.lng);

    if (this.marker) {
      this.marker.setPosition(event.latLng);
    } else {
      this.marker = new (google.maps.Marker)({
        position: event.latLng,
        map: this.map
      });
    }
  }

  addCurrentMarker() {
    if (this.isNewForm()) { return; }

    return this.marker = new (google.maps.Marker)({
      position: new google.maps.LatLng(this.latitudeinput.val(), this.longitudeinput.val()),
      map: this.map
    });
  }

  changeCenterCoords() {
    if (!navigator.geolocation) { return; }

    return navigator.geolocation.getCurrentPosition(position => {
      const center = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
      if (this.isNewForm()) { this.map.setCenter(center); }
    });
  }

  centerLatLng() {
    if (this.isNewForm()) { return new google.maps.LatLng(KAZANLATITUDE, KAZANLONGITUDE); }

    return new google.maps.LatLng(this.latitudeinput.val(), this.longitudeinput.val());
  }

  isNewForm() {
    return (this.latitudeinput.val().length === 0) && (this.longitudeinput.val().length === 0);
  }
}

$.fn.initLocationInput = function() {
  return $(this).each(function() {
    if (!$.data(this, "location-input")) {
      return $.data(this, "location-input", new LocationInput($(this)));
    }
  });
};
