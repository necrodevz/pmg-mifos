class UsersController < ApplicationController

  @@conn = Faraday.new(:url => "https://mifos.pmgjamaica.com:8443")

  def index
    uri = "/mifosng-provider/api/v1/users"
    request = @@conn.get do |req|
      req.url uri
      req.headers['Content-Type'] = 'application/json; charset=utf-8'
      req.headers['X-Mifos-Platform-TenantId'] = 'test'
      req.headers['Authorization'] = "Basic #{session[:base64Key]}"
    end 
    @users = JSON.parse(request.body, :symbolize_names => true)
  end

  def new
    uri = "/mifosng-provider/api/v1/roles"
    request1 = @@conn.get do |req|
      req.url uri
      req.headers['Content-Type'] = 'application/json; charset=utf-8'
      req.headers['X-Mifos-Platform-TenantId'] = 'test'
      req.headers['Authorization'] = "Basic #{session[:base64Key]}"
    end 
    @roles = JSON.parse(request1.body, :symbolize_names => true)

    uri = "/mifosng-provider/api/v1/offices"
    request2 = @@conn.get do |req|
      req.url uri
      req.headers['Content-Type'] = 'application/json; charset=utf-8'
      req.headers['X-Mifos-Platform-TenantId'] = 'test'
      req.headers['Authorization'] = "Basic #{session[:base64Key]}"
    end 
    @offices = JSON.parse(request2.body, :symbolize_names => true)
  end

  def add
    @user = params[:user]
    
    @payload = '{
    "username":"'+@user[:username]+'",
    "firstname":"'+@user[:firstname]+'",
    "lastname":"'+@user[:lastname]+'", 
    "email":"'+@user[:email]+'", 
    "officeId":"'+@user[:officeId]+'", 
    "roles":['+@user[:role]+'], 
    "sendPasswordToEmail":true
    }'
    
    uri = "/mifosng-provider/api/v1/users"
    request = @@conn.post do |req|
      req.url uri
      req.headers['content-type'] = 'application/json'
      req.headers['X-Mifos-Platform-TenantId'] = 'test'
      req.headers['Authorization'] = "Basic #{session[:base64Key]}"
      req.body = @payload
    end 
    redirect_to users_path
  end

  def edit(id = params[:id])
    uri = "/mifosng-provider/api/v1/users/#{id}"
    request = @@conn.get do |req|
      req.url uri
      req.headers['Content-Type'] = 'application/json; charset=utf-8'
      req.headers['X-Mifos-Platform-TenantId'] = 'test'
      req.headers['Authorization'] = "Basic #{session[:base64Key]}"
    end 
    @user = JSON.parse(request.body, :symbolize_names => true)
  end

  def update
  end

  def delete
  end
end
