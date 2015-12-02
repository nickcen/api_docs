class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter CASClient::Frameworks::Rails::Filter,except: [:root_welcome_page]
  before_action :find_or_create_worker
  check_authorization except: [:logout]

  def logout
    session[:worker_id] = nil
    request.env['HTTP_REFERER'] = root_url
    CASClient::Frameworks::Rails::Filter.logout(self)
  end

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end

  def find_or_create_worker
    if session[:worker_id]
      @worker = Worker.find(session[:worker_id])
    elsif session[:cas_user]
      @worker = Worker.find_or_create_by sso_id: session[:cas_user]
      if @worker.name != session[:cas_extra_attributes][:name] || @worker.email != session[:cas_extra_attributes][:email]
        @worker.name = session[:cas_extra_attributes][:name]
        @worker.email = session[:cas_extra_attributes][:email]
        @worker.save
      end
      session[:worker_id] = @worker.id
    end
  end

  def current_user
    return @worker
  end

  rescue_from CanCan::AccessDenied do |exception|
    if session[:cas_user]
      redirect_to root_url, :alert => "您没有访问本页面的权限"
    else
      redirect_to root_url
    end
  end
end
