module Customizables
  class AddCustomAttribute < Actor
    include FailuresConcern

    input :current_user, type: User
    input :customizable, type: [Event, User]
    input :name, type: String
    input :value, type: String
    input :required, type: [TrueClass, FalseClass], default: false

    def call
      if not_authorized?
        raise_authorization_error
      end

      create_custom_attribute
    end

    private

    def not_authorized?
      !CustomizablePolicy.new(current_user, customizable).create?
    end

    def create_custom_attribute
      customizable
        .custom_attributes
        .create!(name: name, value: value, required: required)
    end
  end
end
