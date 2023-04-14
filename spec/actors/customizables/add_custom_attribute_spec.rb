require 'rails_helper'

RSpec.describe Customizables::AddCustomAttribute do
  subject(:actor) do
    described_class.call(
      current_user: current_user,
      customizable: customizable,
      name: name,
      value: value,
      required: required
    )
  end

  let(:current_user) { create :user, :admin}
  let(:customizable) { create :event }
  let(:name) { "Custom Attribute" }
  let(:value) { "Custom Value" }
  let(:required) { false }

  context "when current user is authorized to create a custom attribute" do
    it "creates a new custom attribute for the customizable object" do
      expect { actor }.to change { customizable.custom_attributes.count }.by(1)
      
      custom_attribute = customizable.custom_attributes.last
      expect(custom_attribute.name).to eq(name)
      expect(custom_attribute.value).to eq(value)
      expect(custom_attribute.required).to eq(required)
    end
  end
  
  context "when current user is not authorized to create a custom attribute" do
      let(:current_user) { create :user }

    it "raises an authorization error" do
      expect { actor }.to raise_error(
        'You are not authorized to do this action'
      )
    end
  end
end
