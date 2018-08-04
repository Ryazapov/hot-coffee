class Manage::CoffeePolicy < ApplicationPolicy
  def create?
    record.owner == user
  end

  def show?
    record.owner == user
  end

  def update?
    record.owner == user
  end

  def destroy?
    record.owner == user
  end
end
