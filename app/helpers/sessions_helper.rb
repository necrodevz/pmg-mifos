module SessionsHelper
  
  @@base_uri = "https://mifos.pmgjamaica.com:8443/mifosng-provider/api/v1"
  
  def log_in
    uri = "#{@@base_uri}/offices"
    payload = "{}"
    header = {"X-Mifos-Platform-TenantId" => "test", "Content-Type" => "application/json"}
    @conn = RestClient::Resource.new(uri, params[:sessions][:username], params[:sessions][:password])
    begin
      @req = @conn.get(header)
      flash[:success] = "Connection successful"
      session[:dump] = @req
      session[:username] = params[:sessions][:username]
      session[:password] = params[:sessions][:password]
      flash.now[:alert] = "Login Successful!"
    rescue => e
      session[:error] = e
    end
    
  end
  
  def logout
    destroy_session
    flash.new[:alert] = "Logout was successful"
  end
end