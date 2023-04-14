module Events
  class Create < Actor
    include FailuresConcern

    input :current_user, type: User
    input :name, type: String
    input :description, type: String, allow_nil: true

    output :event, type: Event

    def call
      if not_authorized?
        raise_authorization_error
      end

      create_event
    end

    private

    def not_authorized?
      !EventPolicy.new(current_user, Event).create?
    end

    def create_event
      result.event = Event.create!(name: name, description: description)
    end
  end
end