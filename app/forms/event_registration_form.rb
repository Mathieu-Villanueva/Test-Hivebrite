class EventRegistrationForm < Reform::Form
  model :event

  property :attendee_name, virtual: true
  property :attendee_email, virtual: true

  validates :attendee_name, presence: true
  validates :attendee_email, presence: true

  collection :custom_attributes, form: CustomAttributeForm
end
