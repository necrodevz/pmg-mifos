module MyTokenAuth
	class MyTokenAuth < Faraday::Middleware

		def call(env)
			env[:request_headers]["X-Mifos-Platform-TenantId"] = "test"
			env[:request_headers]["Authorization"] = "RequestStore.store[:base64Key]}"
			@app.call(env)
		end
	end
end