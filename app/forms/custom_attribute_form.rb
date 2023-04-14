class CustomAttributeForm < Reform::Form
  model :custom_attribute

  property :name
  property :value
  property :required
  property :global_attribute, optional: true

  validates :name, presence: true
  validates :value, presence: true, if: :field_required?, on: :update

  private

  def field_required?
    model&.required?
  end
end
