module SessionsHelper
  
  
  Faraday.new(:url => "https://mifos.pmgjamaica.com:8443")

  def log_in
    req = authenticate(params[:sessions][:username], params[:sessions][:password])
    if(!req)
      flash[:danger] = "Login Unsuccessful"
    else
      session[:dump] = req
      @pass = req
      @dota = JSON.parse(req)
      session[:base64Key] = @dota["base64EncodedAuthenticationKey"]
      flash.now[:success] = "Login Successful"
    end
  end

  def authenticate(u, p)
    uri = "/mifosng-provider/api/v1/authentication?username=#{u}&password=#{p}"
    conn = Faraday.new(:url => "https://mifos.pmgjamaica.com:8443")
    conn.basic_auth(u, p)
    bet = conn.post do |req|
      req.url uri
      req.headers['Content-Type'] = 'application/json; charset=utf-8'
      req.headers['X-Mifos-Platform-TenantId'] = 'test'
      req.body = '{}'
    end 
    return bet.body
  end
  
  def logout
    session.delete(:base64Key)
    flash.now[:alert] = "Logout was successful"
  end

  def logged_in?
    if(!!session[:base64Key])
      return true
    else
      return false
    end
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in"
      session[:url] = request.env["REQUEST_PATH"]
      redirect_to login_path
    end
  end
end