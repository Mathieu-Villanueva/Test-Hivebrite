require 'rails_helper'

RSpec.describe Events::Create do
  subject(:actor) do
    described_class.call(
      current_user: current_user,
      name: name,
      description: description
    )
  end

  let(:current_user) { create :user, :admin }
  let(:name) { 'Test Event' }
  let(:description) { 'Test Event Description' }

  it 'creates an event' do
    expect { actor }.to change { Event.count }.by(1)
  end

  it 'returns the created event' do
    expect(actor.event).to be_a(Event)
  end

  context 'when the current user is not authorized to create an event' do
    let(:current_user) { create :user }

    it 'raises an authorization error' do
      expect { actor }.to raise_error(
        'You are not authorized to do this action'
      )
    end
  end
end