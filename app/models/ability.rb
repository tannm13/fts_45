class Ability
  include CanCan::Ability

  def initialize user
   user ||= User.new
    if user.admin?
      can :manage, :all
    elsif user.normal?
      can :update, User, id: user.id
      can [:create, :read], Exam
      can :read, Subject
      can [:read, :edit, :create], Question
    else
      can [:read, :edit, :create], Question
      can :read, Subject
    end
  end
end
