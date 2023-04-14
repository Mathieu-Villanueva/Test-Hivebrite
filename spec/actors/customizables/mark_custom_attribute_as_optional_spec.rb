require 'rails_helper'

RSpec.describe Customizables::MarkCustomAttributeAsOptional do
  subject(:actor) do
    described_class.call(
      attribute_name: attribute_name,
      customizable: user,
      current_user: current_user,
    )
  end

  let(:user) { create :user, :with_custom_attributes }
  let(:attribute_name) { user.custom_attributes.first.name }

  context 'when the params are valid' do
    context 'when the current_user is authorized to edit the user' do
      let(:current_user) { create :user, :admin }

      it 'updates the user' do
        actor

        expect(user.custom_attributes.first.required).to be_falsey
      end
    end

    context 'when the current_user is not authorized to edit the user' do
      let(:current_user) { user }

      it 'does not update the user' do
        expect { actor }.to raise_error(
          'You are not authorized to do this action'
        )
      end
    end
  end

  context 'when the attribute does not exist' do
    let(:current_user) { create :user, :admin }

    context 'when the custom attributes are invalid' do
      let(:attribute_name) { 'test' }

      it 'fails the actor' do
        expect { actor }.to raise_error('Attribute does not exist')
      end
    end
  end
end