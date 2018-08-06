FactoryGirl.define do
  factory :coffee_house do
    name Faker::Company.name
    description Faker::Lorem.paragraphs
    latitude 55.78787607694294
    longitude 49.12356007675169
    address "Ulitsa Butlerova, 4, Kazan, Russia"
    association :owner, factory: :user

    trait :kazan_butlerova do
      latitude 55.78787607694294
      longitude 49.12356007675169
      address "Ulitsa Butlerova, 4, Kazan, Russia"
    end

    trait :kazan_profsoyuznaya do
      latitude 55.78778545536969
      longitude 49.122609570622444
      address "Profsoyuznaya Ulitsa, 50, Kazan, Russia"
    end

    trait :moscow_red_square do
      latitude 55.754270
      longitude 37.621277
      address "Red Square, 3, Moscow, Russia"
    end
  end
end
