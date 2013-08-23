class ApplicationController < ActionController::Base
  include Clearance::Controller
  include CommandBus

  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

end
