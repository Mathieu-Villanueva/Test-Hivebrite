class CustomizablePolicy < ApplicationPolicy
  def show?
    return true if admin?
    return true if record.is_a?(Event)

    self?
  end

  def create?
    admin?
  end

  def edit?
    admin?
  end

  def update?
    show?
  end
end
