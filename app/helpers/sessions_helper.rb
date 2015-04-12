module SessionsHelper
  def log_in
    session[:username] = params[:sessions][:username]
    session[:password] = params[:sessions][:password]
    flash.now[:alert] = "Login Successful!"
  end
  
  def logout
    destroy_session
    flash.new[:alert] = "Logout was successful"
  end
end