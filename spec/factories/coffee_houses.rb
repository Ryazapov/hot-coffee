FactoryGirl.define do
  factory :coffee_house do
    name Faker::Company.name
    description Faker::Lorem.paragraphs
    latitude 55.78787607694294
    longitude 49.12356007675169
    address "Ulitsa Butlerova, 4, Kazan, Russia"
    association :owner
  end
end
