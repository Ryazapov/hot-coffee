FactoryGirl.define do
  factory :provider, aliases: %i[facebook_provider] do
    name "Facebook"
    uid { SecureRandom.uuid }

    association :user, strategy: :build
  end
end
