class UserPolicy < ApplicationPolicy
  def show?
    admin? || self?
  end

  def create?
    admin?
  end

  def update?
    admin? || self?
  end
end
