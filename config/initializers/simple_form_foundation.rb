# frozen_string_literal: true

# Uncomment this and change the path if necessary to include your own
# components.
# See https://github.com/plataformatec/simple_form#custom-components to know
# more about custom components.
# Dir[Rails.root.join('lib/components/**/*.rb')].each { |f| require f }
#
# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  config.wrappers :vertical_form do |b|
    b.use :html5
    b.use :placeholder

    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly

    b.use :label, error_class: "is-invalid-label"
    b.use :input, error_class: "is-invalid-input"
    b.use :error, wrap_with: { tag: :small, class: "form-error is-visible" }
    b.use :hint, wrap_with: { tag: :p, class: "help-text" }
  end

  config.wrappers :horizontal_form, class: "grid-x grid-padding-x" do |b|
    b.use :html5
    b.use :placeholder

    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly

    b.wrapper :label_wrapper, class: "small-3 cell" do |ba|
      ba.use :label, class: "text-right", error_class: "is-invalid-label"
    end

    b.wrapper :input_wrapper, class: "small-9 cell" do |ba|
      ba.use :input, error_class: "is-invalid-input"
      ba.use :error, wrap_with: { tag: :small, class: "form-error is-visible" }
      ba.use :hint, wrap_with: { tag: :p, class: "help-text" }
    end
  end

  config.wrappers :group_form do |b|
    b.use :html5
    b.use :placeholder

    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly

    b.wrapper :group, class: "input-group" do |ba|
      ba.use :label, class: "input-group-label", error_class: "is-invalid-label"
      ba.use :input, class: "input-group-field", error_class: "is-invalid-input"
    end
    b.use :error, wrap_with: { tag: :small, class: "form-error is-visible" }
    b.use :hint,  wrap_with: { tag: :p, class: "help-text" }
  end

  # CSS class for buttons
  config.button_class = "button"

  # You can wrap each item in a collection of radio/check boxes with a tag,
  # defaulting to :span.
  config.item_wrapper_tag = nil

  # CSS class to add for error notification helper.
  config.error_notification_class = "alert-box alert"

  # The default wrapper to be used by the FormBuilder.
  config.default_wrapper = :vertical_form

  # You can wrap a collection of radio/check boxes in a pre-defined tag, defaulting to none.
  config.collection_wrapper_tag = :fieldset
end
