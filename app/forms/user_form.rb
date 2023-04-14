class UserForm < Reform::Form
  model :user

  property :email

  collection :custom_attributes,
             populate_if_empty: CustomAttribute,
             form: CustomAttributeForm

  validates :email, presence: true
  validate :attributes_presence

  def global_attributes
    GlobalAttribute.active
  end

  def attributes_presence
    global_attributes.required.each do |global_attribute|
      attribute =
        custom_attributes.detect do |attr| 
          attr.model.name == global_attribute.name
        end

      if attribute
        attribute.model.required = global_attribute.required
      else
        errors.add(
          :custom_attributes,
          "#{global_attribute.name} is missing"
        )
      end
    end
  end
end
