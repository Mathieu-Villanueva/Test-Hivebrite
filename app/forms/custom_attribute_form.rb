class CustomAttributeForm < Reform::Form
  model :custom_attribute

  property :name
  property :value
  property :required
  property :global_attribute, optional: true

  validates :name, presence: true

  validate :attribute_value

  private

  def attribute_value
    if field_required? && value.blank?
      errors.add(:value, "is missing on #{model.name}") 
    end
  end

  def field_required?
    model&.required?
  end
end
