class EventPolicy < ApplicationPolicy
  def show?
    true
  end

  def create?
    admin?
  end

  def edit?
    admin?
  end

  def update?
    admin?
  end
end
