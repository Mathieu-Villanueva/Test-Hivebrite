module Events
  class Register < Actor
    include FailuresConcern

    input :current_user, type: User
    input :event_name, type: String
    input :user_name, type: String
    input :event_attributes, type: Array

    def call
      if not_authorized?
        raise_authorization_error
      end

      form = EventRegistrationForm.new(event)

      if form.validate(params)
        puts 'Congrats, you are registered!'
      else
        fail!(error: form.errors.full_messages.to_s)
      end
    end

    private

    def not_authorized?
      !EventPolicy.new(current_user, event).register?
    end

    def event
      @event ||= Event.find_by(name: event_name)
    end

    def params
      {
        attendee_name: user_name,
        attendee_email: current_user.email,
        custom_attributes: event_attributes
      }
    end
  end
end
