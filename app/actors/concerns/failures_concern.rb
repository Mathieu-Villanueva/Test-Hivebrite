module FailuresConcern
  extend ActiveSupport::Concern

  private

  def raise_authorization_error
    fail!(error: 'You are not authorized to do this action')
  end
end
