class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= Worker.new
    if user.admin?
      can :manage, Worker
    end

    puts "#{user}"

    can [:root_welcome_page], Worker do |worker|
      true
    end

    if user.developer? || user.tester?
      can [:manage], App
      can [:manage], Spec
    end
  end
end
