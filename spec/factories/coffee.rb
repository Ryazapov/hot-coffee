FactoryGirl.define do
  factory :coffee do
    name Faker::Coffee.blend_name
    kind "hot_coffee"
    volume 500
    price 200
    description Faker::Coffee.notes

    association :coffee_house
  end
end
