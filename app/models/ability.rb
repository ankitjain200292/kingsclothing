class Ability
  # function for checking the user role by the cancan plugin
  include CanCan::Ability
  def initialize(user)
    user ||= User.new # guest user
    
    if user.role == 1
      can :manage, :all
    elsif user.role == 2
      can :read, :all
    elsif user.role == 3
      can :read, :all
      can [:create, :update], [Photo, Story,Video]
    elsif user.role == 4
      can :read, :all
      can [:create, :update], [Photo, Story,Video]
    end
  end
end
