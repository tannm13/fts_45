class Ability
  include CanCan::Ability

  def initialize user
   user ||= User.new
    if user.admin?
      can :manage, :all
    elsif user.normal?
      can :update, User, id: user.id
      can :create, Exam
      can :read, Subject
    else
      cannot :manage, :all
    end
  end
end
