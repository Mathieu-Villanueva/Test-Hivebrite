require 'rails_helper'

RSpec.describe Events::Register do
  subject(:actor) do
    described_class.call(
      current_user: current_user,
      event_name: event.name,
      user_name: attendee_name,
      event_attributes: custom_attributes
    )
  end

  let(:current_user) { create :user }
  let(:event) { create :event, :with_empty_attributes }
  let(:attendee_name) { 'John Doe' }

  let(:custom_attributes) do
    [
      {
        name: event.custom_attributes.first.name,
        value: 'John Doe'
      },
    ]
  end

  context 'when the registration form is valid' do
    it 'prints a success message' do
      expect { actor }.to output("Congrats, you are registered!\n").to_stdout
    end
  end

  context 'when the registration form is invalid' do
    let(:attendee_name) { nil }

    it 'raises an error with the form errors' do
      expect { actor }.to raise_error(
        ServiceActor::ArgumentError,
        'The "user_name" input on "Events::Register" does not allow nil values'
      )
    end
  end

  context 'when a required custom attribute is missing' do
    before do
      event.custom_attributes.second.update(required: true)
    end

    it 'raises an error with the form errors' do
      expect { actor }.to raise_error(ServiceActor::Failure)
    end
  end
end
