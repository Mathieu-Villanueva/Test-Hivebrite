module Users
  class SignUp < Actor
    include FailuresConcern

    input :params, type: Hash

    output :user, type: User

    def call
      prepare_user

      form = UserForm.new(@user)
      
      if form.valid?
        form.save!
        result.user = form.model
      else
        fail!(error: form.errors.full_messages.to_s)
      end
    end

    private

    def prepare_user
      @user = User.new(
        email: params[:email],
        custom_attributes: custom_attributes
      )
    end

    def custom_attributes
      custom_attributes ||=
        params[:attributes].map do |attribute|
          CustomAttribute.new(
            name: attribute[:name],
            value: attribute[:value]
        )
      end
    end
  end
end
