class UserPolicy < ApplicationPolicy
  def update?
    admin? || self?
  end
end
