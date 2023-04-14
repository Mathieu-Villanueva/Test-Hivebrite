require 'rails_helper'

RSpec.describe Customizables::EditCustomAttributeName do
  subject(:actor) do
    described_class.call(
      new_name: new_name,
      attribute_name: attribute_name,
      customizable: customizable,
      current_user: current_user,
    )
  end

  let(:customizable) { create :event }
  let(:custom_attribute) { create :custom_attribute, customizable: customizable }
  let(:current_user) { create :user }

  describe '#call' do
    context 'when the params are valid' do
      let(:new_name) { 'new_name' }
      let(:attribute_name) { custom_attribute.name }

      before do
        allow_any_instance_of(CustomizablePolicy).to receive(:edit?).and_return(true)
      end

      it 'updates the custom attribute name' do
        actor

        expect(custom_attribute.reload.name).to eq('new_name')
      end

      context 'when the custom attribute is global' do
        let(:global_attribute) { create :global_attribute }

        let(:custom_attribute) do
          create :custom_attribute,
          customizable: customizable,
          global_attribute: global_attribute
        end

        it 'raises an error' do
          expect { actor }.to raise_error(
            'Cannot edit name of attribute with a global attribute linked'
          )
        end
      end

      context 'when the current_user is not authorized to edit the customizable' do
        before do
          allow_any_instance_of(CustomizablePolicy).to receive(:edit?).and_return(false)
        end

        it 'raises an error' do
          expect { actor }.to raise_error('You are not authorized to do this action')
        end
      end

      context 'when the custom attribute does not exist' do
        let(:attribute_name) { 'invalid_name' }

        it 'raises an error' do
          expect { actor }.to raise_error('Attribute does not exist')
        end
      end
    end
  end
end
