class HousingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    user_admin_or_diag
  end

  def valuations?
    user_admin_or_diag
  end

  def create?
    user_admin_or_diag
  end

  def update?
    user_admin_or_diag
  end

  def destroy?
    user_admin_or_diag
  end

  def new
    user_admin_or_diag
  end
end
