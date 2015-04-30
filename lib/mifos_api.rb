require 'faraday'
require 'faraday_middleware'
require	'her'
require 'request_store'
require 'mifos_api/my_token_auth'

module MifosApi
	module V1
		class ClientNotConfigured < Exception; end

		def self.configure(host, &block)
			@api = Her::API.new

			@api.setup :url => "https://#{host}/mifosng-provider/api/v1" do |c|

				c.use FaradayMiddleware::EncodeJson
				c.use Her::Middleware::AcceptJSON
				c.use Her::Middleware::FirstLevelParseJSON
				c.use MyTokenAuth

				yield c if block_given?

				c.adapter Faraday.default_adapter unless c.builder.handlers.include?(Faraday::Adapter::Test)
			end

			require "#{Rails.root}/lib/models"
		end

		def self.api
			raise ClientNotConfigured.new(Mifos) unless @api
			@api
		end
	end
end
