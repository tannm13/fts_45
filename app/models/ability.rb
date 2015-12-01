class Ability
  include CanCan::Ability

  def initialize user
   user ||= User.new
    if user.admin?
      can :manage, :all
    else user.normal?
      can :update, User, id: user.id
      can [:create, :read, :update], Exam
      can :index, Subject
      can [:create, :index, :edit, :update], Question
    end
  end
end
