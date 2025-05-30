class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?
    can :read, :all
    can :create, Message
    can [:update, :destroy], Message, user_id: user.id
    can [:update, :destroy], User, id: user.id
    can :read, Chat, sender_id: user.id
    can :read, Chat, receiver_id: user.id
    can :create, Chat
    can [:edit, :update], Chat, sender_id: user.id
    can [:edit, :update], Chat, receiver_id: user.id
  end
end