class Manage::CoffeeHousePolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    true
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
