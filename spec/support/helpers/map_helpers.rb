module MapHelpers
  def choose_location_on_map(model_name:, latitude:, longitude:)
    find("input##{model_name}_latitude", visible: false).set(latitude)
    find("input##{model_name}_longitude", visible: false).set(longitude)
  end
end
