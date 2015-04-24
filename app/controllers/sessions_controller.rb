class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    log_in
    @data = session[:dump]
    @data2 = JSON.parse(@data)
    #redirect_to root_path
  end
  
  def destroy
    
  end
  
  def dashboard
    
  end
end
