class Worker < ActiveRecord::Base

  attr_accessible :sso_id, :name, :email, :is_admin, :is_developer, :is_tester

  scope :admins, -> {where(:is_admin => true)}
  def admin?
    return is_admin
  end

  def developer?
    return is_developer
  end

  def tester?
    return is_tester
  end
end
