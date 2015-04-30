class ClientsController < ApplicationController

	def index
    uri = "/mifosng-provider/api/v1/clients"
    conn = Faraday.new(:url => "https://mifos.pmgjamaica.com:8443")
    @clients = conn.get do |req|
      req.url uri
      req.headers['Content-Type'] = 'application/json; charset=utf-8'
      req.headers['X-Mifos-Platform-TenantId'] = 'test'
      req.headers['Authorization'] = "Basic #{session[:base64Key]}"
    end 
  end

  def add
  	
  end
end
