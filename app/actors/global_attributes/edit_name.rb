module GlobalAttributes
  class EditName < Actor
    include FailuresConcern

    input :attribute_name, type: String
    input :new_name, type: String

    def call
      if not_authorized?
        raise_authorization_error 
      end
      
      raise_attribute_does_not_exist_error unless global_attribute

      edit_name
      edit_custom_attributes_names
    end

    private

    def not_authorized?
      !GlobalAttributePolicy.new(current_user, GlobalAttribute).edit?
    end
    
    def global_attribute
      @global_attribute ||= GlobalAttribute.find_by(name: attribute_name)
    end

    def edit_name
      global_attribute.update(name: new_name)
    end

    def edit_custom_attributes_names
      global_attribute.custom_attributes.each do |custom_attribute|
        custom_attribute.update(name: new_name)
      end
    end
  end
end