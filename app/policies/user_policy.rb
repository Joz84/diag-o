class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    user_admin_or_diag
  end

  def show?
    user_admin_or_current_user
  end

  def new?
    user_admin_or_diag
  end

  def create?
    true
  end

  def update?
    user_admin_or_diag
  end

  def destroy?
    user_admin_or_diag
  end
end
