class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    can :read, [Post, Event]
    can :archive, Post
    can :show, Page
    can :show, Upload

    if user.admin?
      can :manage, :all
    elsif user.editor?
      can :manage, [Post, Upload, Page, Image]
      can :manage, ContactForm
    elsif user.events?
      can :manage, Event
      can :manage, Image
    end

    can :show, Upload

    if User.exists?(user.id)
      can :read, Upload
      can [:update, :destroy], user
      can :manage, user.contact_forms
      can [:update, :add_user, :remove_user], user.pages
    end
  end
end
