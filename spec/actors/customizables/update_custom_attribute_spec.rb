require 'rails_helper'

RSpec.describe Customizables::UpdateCustomAttribute do
  subject(:actor) do
    described_class.call(
      attribute_name: attribute_name,
      customizable: customizable,
      new_value: value,
      current_user: current_user)
  end

  let(:customizable) { create :user, :with_custom_attributes }
  let(:attribute_name) { customizable.custom_attributes.first.name }
  let(:value) { 'new_value' }
  let(:current_user) { create :user, :admin }

  context 'when the params are valid' do
    context 'when the current_user is authorized to edit the user' do
      it 'updates the user' do
        expect { actor }.to change {
          customizable.custom_attributes.first.value
        }.to('new_value')
      end
    end

    context 'when the current_user is the user' do
      let(:current_user) { customizable }

      it 'does not update the user' do
        expect { actor }.to change {
          customizable.custom_attributes.first.value
        }.to('new_value')
      end
    end

    context 'when the current_user is not authorized to edit the user' do
      let(:current_user) { create :user }

      it 'does not update the user' do
        expect { actor }.to raise_error(
          'You are not authorized to do this action'
        )
      end
    end

    context 'with an event' do
      let(:current_user) { create :user }
      let(:customizable) { create :event, :with_custom_attributes }

      it 'does not update the user' do
        expect { actor }.to change {
          customizable.custom_attributes.first.value
        }.to('new_value')
      end
    end
  end

  context 'when the attribute does not exist' do
    let(:attribute_name) { 'test' }

    it 'fails the actor' do
      expect { actor }.to raise_error('Attribute does not exist')
    end
  end
end
