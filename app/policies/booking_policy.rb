class BookingPolicy < ApplicationPolicy
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

  def create?
    # user_admin_or_diag_or_owner
    true
  end

  def update?
    user_admin_or_diag
  end

  def destroy?
    user_admin_or_diag
  end

  def add_comment?
    true
  end

  def delete_comment?
    true
  end

end
