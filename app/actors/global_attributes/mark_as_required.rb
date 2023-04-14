module GlobalAttributes
  class MarkAsRequired < Actor
    include FailuresConcern

    input :current_user, type: User
    input :attribute_name, type: String

    def call
      if not_authorized?
        raise_authorization_error 
      end
      
      raise_attribute_does_not_exist_error unless global_attribute

      mark_as_required
    end

    private

    def not_authorized?
      !GlobalAttributePolicy.new(current_user, global_attribute).edit?
    end
    
    def global_attribute
      @global_attribute ||= GlobalAttribute.find_by(name: attribute_name)
    end

    def mark_as_required
      global_attribute.update(required: true)
    end
  end
end