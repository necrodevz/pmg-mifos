module ApiHelper
  class Api
    include HTTParty
    
    base_uri 'https://mifos.pmgjamaica.com:8443/mifosng-provider/api/v1/'
    
    def initialize(user, password)
      @auth = {:username => user, :password => password}
    end
    
    def post(url, headers={}, payload = {})
      headers.merge!("Content-Type" => "application/json")
      @options = ({:query => {tenantIdentifier: "test"}, :headers => headers, :body=> payload, :basicauth=> @auth})
      self.class.post(url, @options)
    end
    
    def get(url, headers={}, query = {})
      headers.merge!(:tenantIdentifier=> "test", "Content-Type" => "application/json")
      @options.merge!({:headers => headers, :query=> query, :basicauth=> @auth})
      self.class.get(url, @options)
    end
  end
end
