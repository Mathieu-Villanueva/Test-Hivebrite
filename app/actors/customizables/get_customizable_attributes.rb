module Customizables
  class GetCustomizableAttributes < Actor
    include FailuresConcern

    input :current_user, type: User
    input :customizable, type: Customizable

    def call
      if not_authorized?
        raise_authorization_error
      end

      customizable.custom_attributes
    end

    private

    def not_authorized?
      !CustomizablePolicy.new(current_user, customizable).show?
    end
  end
end