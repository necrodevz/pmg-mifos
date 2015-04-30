class SessionsController < ApplicationController
  
  skip_before_action :logged_in_user

  def new
  end
  
  def create
    log_in
    if(!!session[:url])
      url = session[:url]
      session.delete(:url)
      redirect_to url
    else
      redirect_to root_path
    end
  end
  
  def destroy
    logout
    redirect_to root_path
  end
  
  def dashboard
    
  end
end
