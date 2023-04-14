module GlobalAttributes
  class EditRequiredField < Actor
    include FailuresConcern

    input :current_user, type: User
    input :attribute_name, type: String
    input :required, type [TrueClass, FalseClass], default: false

    def call
      if not_authorized?
        raise_authorization_error 
      end
      
      raise_attribute_does_not_exist_error unless global_attribute

      edit_required_field
    end

    private

    def not_authorized?
      !GlobalAttributePolicy.new(current_user, global_attribute).edit?
    end
    
    def global_attribute
      @global_attribute ||= GlobalAttribute.find_by(name: attribute_name)
    end

    def edit_required_field
      global_attribute.update(required: required)
    end
  end
end