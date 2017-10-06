class DiagnosticPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    user_admin_or_diag
  end

  def show?
    user_admin_or_diag_or_owner
  end

  def new?
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

  def add_plan?
    user.diagnostician? or user.admin?
  end

  def delete_plan?
    user.diagnostician? or user.admin?
  end
end


