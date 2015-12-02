class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= Worker.new
    if user.admin?
      can :manage, Worker
    end

    can [:root_welcome_page], Worker do |worker|
      true
    end

    can [:manage], App do |worker|
      worker.developer? || worker.tester?
    end

    can [:manage], Spec do |worker|
      worker.developer? || worker.tester?
    end
  end
end
