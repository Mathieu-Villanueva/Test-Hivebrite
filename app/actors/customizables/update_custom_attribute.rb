module Customizables
  class UpdateCustomAttribute < Actor
    include FailuresConcern

    input :current_user, type: User
    input :attribute_name, type: String
    input :new_value, type: String
    input :customizable, type: [User, Event]

    def call
      if not_authorized?
        raise_authorization_error
      end
      
      raise_attribute_does_not_exist_error unless custom_attribute

      update_custom_attribute_value
    end

    private

    def not_authorized?
      !CustomizablePolicy.new(current_user, customizable).update?
    end

    def update_custom_attribute_value
      custom_attribute.update(value: new_value)
    end

    def custom_attribute
      @custom_attribute ||=
        customizable.custom_attributes.find_by(name: attribute_name)
    end
  end
end
