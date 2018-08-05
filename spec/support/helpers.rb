Dir[Rails.root.join("spec", "support", "helpers", "**", "*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.with_options(type: :feature) do |feature|
    feature.include MapHelpers
  end
end
