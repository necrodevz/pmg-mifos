class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :logged_in_user
  
  include SessionsHelper
  #include MyTokenAuth

  before_filter :set_user_api_token

  protected
  def set_user_api_token
    RequestStore.store[:mytoken] = session[:base64Key]
    #RequestStore.store[:tenant] = "test"
  end

end
