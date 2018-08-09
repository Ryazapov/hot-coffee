const KAZAN_LATITUDE = 55.788258;
const KAZAN_LONGITUDE = 49.119290;

class CurrentCoordinates {
  constructor(coordinates = []) {
    this.latitude = coordinates[0] || KAZAN_LATITUDE;
    this.longitude = coordinates[1] || KAZAN_LONGITUDE;

    this.getCurrentPosition();
  }

  getCurrentPosition() {
    if (navigator.geolocation) {
      const options = {
        maximumAge: 1000
      };

      navigator.geolocation.getCurrentPosition(position => {
        this.latitude = position.coords.latitude;
        this.longitude = position.coords.longitude;

        cookie.set('latitude', this.latitude, { path: "/" });
        cookie.set('longitude', this.longitude, { path: "/" });

        const event = new Event('position:update');
        document.dispatchEvent(event);
      },
      () => {
        cookie.remove('latitude');
        cookie.remove('longitude');
      }, options);
    }
  }
}

App.currentCoordinates = new CurrentCoordinates(App.currentCoordinatesData);
