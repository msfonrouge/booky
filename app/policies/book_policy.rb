class BookPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
    def index
      user.admin?
      flash[:alert] = 'You are not authorized to perform this action.'
    end
  end
end
