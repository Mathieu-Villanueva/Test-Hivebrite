module Customizables
  class MarkCustomAttributeAsRequired < Actor
    include FailuresConcern
    
    fail_on ServiceActor::ArgumentError

    input :current_user, type: User
    input :attribute_name, type: String
    input :customizable, type: [User, Event]

    def call
      if not_authorized?
        raise_authorization_error
      end
      
      raise_attribute_does_not_exist_error unless custom_attribute

      mark_as_required
    end

    private

    def not_authorized?
      !CustomizablePolicy.new(current_user, customizable).edit?
    end

    def mark_as_required
      custom_attribute.update(required: true)
    end

    def custom_attribute
      @custom_attribute ||=
        customizable.custom_attributes.find_by(name: attribute_name)
    end
  end
end
