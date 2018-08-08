class ClientCoordinates {
  updatePosition() {
    if (navigator.geolocation) {
      const options = {
        maximumAge: 1000
      };

      navigator.geolocation.getCurrentPosition(position => {
        cookie.set('latitude', position.coords.latitude, { path: "/" });
        cookie.set('longitude', position.coords.longitude, { path: "/" });

        if (App.clientCoordinates[0] === null) { location.reload(); }
      }, ()=>{}, options);
    }
  }
}

new ClientCoordinates().updatePosition();
