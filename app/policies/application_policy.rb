class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  private

  def admin?
    user.admin?
  end

  def self?
    user == record
  end
end
