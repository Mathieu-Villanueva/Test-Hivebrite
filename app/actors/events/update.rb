module Events
  class Update < Actor
    include FailuresConcern

    input :current_user, type: User
    input :description, type: String, allow_nil: true
    input :event, type: Event
    input :name, type: String

    def call
      if not_authorized?
        raise_authorization_error
      end

      update_event
    end

    private

    def not_authorized?
      !EventPolicy.new(current_user, event).update?
    end

    def update_event
      event.update(name: name, description: description)
    end
  end
end
