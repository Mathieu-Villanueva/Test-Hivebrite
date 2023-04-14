module Customizables
  class EditCustomAttributeName < Actor
    include FailuresConcern

    input :current_user, type: User
    input :attribute_name, type: String
    input :customizable, type: [Event, User]
    input :new_name, type: String

    def call
      if not_authorized?
        raise_authorization_error
      end
      
      raise_attribute_does_not_exist_error unless custom_attribute
      raise_can_not_edit_name_error if global_attribute?

      update_custom_attribute_name
    end

    private

    def not_authorized?
      !CustomizablePolicy.new(current_user, customizable).edit?
    end

    def custom_attribute
      @custom_attribute ||=
        customizable.custom_attributes.find_by(name: attribute_name)
    end

    def update_custom_attribute_name
      custom_attribute.update!(name: new_name)
    end

    def global_attribute?
      custom_attribute.global_attribute.present?
    end
  end
end