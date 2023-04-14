module Users
  class UpdateEmail < Actor
    include FailuresConcern

    input :current_user, type: User
    input :email, type: String
    input :user, type: User

    def call
      if not_authorized?
        raise_authorization_error
      end

      update_user
    end

    private

    def not_authorized?
      !UserPolicy.new(current_user, user).update?
    end

    def update_user
      user.update!(email: email)
    end
  end
end
