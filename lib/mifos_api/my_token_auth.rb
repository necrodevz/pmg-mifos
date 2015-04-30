module MifosApi
	module V1
		class MyTokenAuth < Faraday::Middleware

			def call(env)
				env[:request_headers]["X-Mifos-Platform-TenantId"] = "#{RequestStore.store[:tenant]}"
				env[:request_headers]["Authorization"] = "Basic #{RequestStore.store[:base64Key]}"
				@app.call(env)
			end
		end
	end
end