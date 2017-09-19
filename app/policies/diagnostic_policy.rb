class DiagnosticPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    user.diagnostician? or user.admin?
  end

  def show?
    true
  end

  def new?
    user.diagnostician? or user.admin?
  end

  def create?
    user.diagnostician? or user.admin?
  end

  def update?
    user.diagnostician? or user.admin?
  end

  def destroy?
    user.diagnostician? or user.admin?
  end

end
