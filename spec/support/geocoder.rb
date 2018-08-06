Geocoder.configure(lookup: :test)

Geocoder::Lookup::Test.set_default_stub(
  [{
    "coordinates" => [55.79288, 49.11048],
    "address" => "Bauman St, Kazan, Russia"
  }]
)

Geocoder::Lookup::Test.add_stub(
  [55.78787607694294, 49.12356007675169], [{
    "coordinates" => [55.78787607694294, 49.12356007675169],
    "address" => "Ulitsa Butlerova, 4, Kazan, Russia"
  }]
)

Geocoder::Lookup::Test.add_stub(
  [55.78778545536969, 49.122609570622444], [{
    "coordinates" => [55.78778545536969, 49.122609570622444],
    "address" => "Profsoyuznaya Ulitsa, 50, Kazan, Russia"
  }]
)
