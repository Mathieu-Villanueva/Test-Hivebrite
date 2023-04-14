class EventPolicy < ApplicationPolicy
  def create?
    admin?
  end

  def edit?
    admin?
  end

  def update?
    admin?
  end

  def register?
    return false if user.email.blank?

    true
  end
end
