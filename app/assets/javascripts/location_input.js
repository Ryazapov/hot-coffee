const LATITUDE_INPUT_SELECTOR = "#coffee_house_latitude";
const LONGITUDE_INPUT_SELECTOR = "#coffee_house_longitude";

class LocationInput {
  constructor($locationInput) {
    this.locationInput = $locationInput;
    this.latitudeInput = $(LATITUDE_INPUT_SELECTOR);
    this.longitudeInput = $(LONGITUDE_INPUT_SELECTOR);
    this.setupMap();
  }

  setupMap() {
    this.map = new google.maps.Map(this.locationInput, this.mapOptions());
    this.map.addListener("click", event => {
      this.latitudeInput.val(event.latLng.lat);
      this.longitudeInput.val(event.latLng.lng);

      if (this.marker) {
        this.marker.setPosition(event.latLng);
      } else {
        this.marker = new (google.maps.Marker)({
          position: event.latLng,
          map: this.map
        });
      }
    });

    this.addCurrentMarker();
    this.changeCenterCoords();
  }

  mapOptions() {
    return {
      zoom: 15,
      center: this.centerLatLng(),
    };
  }

  addCurrentMarker() {
    if (this.isNewForm()) { return; }

    return this.marker = new (google.maps.Marker)({
      position: new google.maps.LatLng(this.latitudeInput.val(), this.longitudeInput.val()),
      map: this.map
    });
  }

  changeCenterCoords() {
    if (App.clientCoordinates[0] === null) { return; }

    const center = new google.maps.LatLng(App.clientCoordinates[0], App.clientCoordinates[1]);
    if (this.isNewForm()) { this.map.setCenter(center); }
  }

  centerLatLng() {
    if (this.isNewForm()) { return new google.maps.LatLng(KAZAN_LATITUDE, KAZAN_LONGITUDE); }

    return new google.maps.LatLng(this.latitudeInput.val(), this.longitudeInput.val());
  }

  isNewForm() {
    return (this.latitudeInput.val().length === 0) && (this.longitudeInput.val().length === 0);
  }
}

const LOCATION_INPUT_SELECTOR = "location-input";
const $locationInputs = document.getElementsByClassName(LOCATION_INPUT_SELECTOR);

[...$locationInputs].forEach(($locationInput) => {
  new LocationInput($locationInput);
});
