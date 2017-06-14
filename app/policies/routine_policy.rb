class RoutinePolicy < ApplicationPolicy
  def index?
    record_belongs_to_user?
  end

  def show?
    index?
  end

  def update?
    index?
  end

  def destroy?
    index?
  end

  class Scope < Scope
    def resolve
      Routine.where(user_id: user.id).or(Routine.where(public: true))
    end
  end

end
