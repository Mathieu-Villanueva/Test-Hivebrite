module GlobalAttributes
  class Create < Actor
    include FailuresConcern

    input :current_user, type: User
    input :attribute_name, type: String
    input :required, type [TrueClass, FalseClass], default: false

    def call
      if not_authorized?
        raise_authorization_error 
      end

      create_global_attribute
    end

    private

    def not_authorized?
      !GlobalAttributePolicy.new(current_user, GlobalAttribute).create?
    end

    def create_global_attribute
      GlobalAttribute.create(name: attribute_name, required: required)
    end
  end
end