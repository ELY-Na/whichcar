class FavouritePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.where(user: user)
    end
  end

  def create?
    record.user == user
  end

  def show?
    record.user == user
  end

  def destroy?
    record.user == user
  end

  def delete_fav_index?
    record.user == user
  end
end
