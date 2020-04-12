class LocationService

  class << self
    def get_address_info(address)
      begin
        connection.post(path: "/api/address/eligibility_check",
                          body: address.to_json,
                          headers: { "Content-Type" => "application/json",
                                     "Api_Token" => api_token }
                        )
      rescue StandardError
        Excon::Response.new({ body=>"Location service error", :status=>500 })
      end

    end

    def host
      ENV["LOCATION_SERVICE_HOST"]
    end

    def api_token
      ENV["LOCATION_SERVICE_API_TOKEN"]
    end

    def connection
      Excon.new(host)
    end
  end
end
