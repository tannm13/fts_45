class Ability
  include CanCan::Ability

  def initialize user
   user ||= User.new
    if user.admin?
      can :manage, :all
    elsif user.normal?
      can :update, User, id: user.id
      can [:create, :read], Exam
      can :index, Subject
      can [:create, :index, :edit, :update], Question
    else
      can [:index, :edit, :create], Question
      can :index, Subject
    end
  end
end
