class NullResourcePolicy < ApplicationPolicy
  authorize :user, allow_nil: true

  def index?
    true
  end

  def create?
    false
  end

  def show?
    true
  end

  def update?
    false
  end

  def destroy?
    false
  end
end
