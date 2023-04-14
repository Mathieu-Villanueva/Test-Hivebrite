class GlobalAttributePolicy < ApplicationPolicy
  def show?
    true
  end

  def create?
    admin?
  end

  def edit?
    admin?
  end
end
