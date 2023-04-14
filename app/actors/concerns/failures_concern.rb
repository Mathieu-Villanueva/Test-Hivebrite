module FailuresConcern
  extend ActiveSupport::Concern

  private

  def raise_attribute_does_not_exist_error
    fail!(error: 'Attribute does not exist')
  end

  def raise_authorization_error
    fail!(error: 'You are not authorized to do this action')
  end
end
