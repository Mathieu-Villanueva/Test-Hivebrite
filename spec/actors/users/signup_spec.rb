require 'rails_helper'

RSpec.describe Users::SignUp do
  subject(:actor) { described_class.call(params: params) }
  
  let(:email) { "test@test.com" }
  let!(:global_attribute) { create :global_attribute, :required, name: "first" }
  let!(:global_attribute2) { create :global_attribute, name: "second" }

  let(:params) do
    {
      email: email,
      attributes: attributes
    }
  end

  context "with valid params" do
    let(:attributes) do
      [
        {
          name: global_attribute.name,
          value: "this attribute is required",
          required: global_attribute.required
        },
        {
          name: global_attribute2.name,
          value: "this one is not",
          required: global_attribute2.required
        }
      ]
    end

    it "creates a new user with custom attributes" do
      expect { actor }.to change(User, :count).by(1)

      user = User.last
      expect(user.email).to eq(email)

      expect(user.custom_attributes.count).to eq(2)
      
      expect(
        user.custom_attributes.find_by(name: global_attribute.name).value
      ).to eq("this attribute is required")
      
      expect(
        user.custom_attributes.find_by(name: global_attribute2.name).value
      ).to eq("this one is not")
    end
  end

  context "with missing required attributes" do
    let(:attributes) do
      [{ name: 'second', value: "this one is not" }]
    end

    it "raises a validation error" do
      expect { actor }.to raise_error(ServiceActor::Failure)
    end
  end
end
