class InscriptionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def disponibility?
    true
  end

  def checkpoint
    true
  end

  def confirmation
    true
  end

end
