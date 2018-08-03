class ApplicationPolicy < ActionPolicy::Base
  alias_rule :new?, to: :create?
  alias_rule :edit?, to: :update?
end
