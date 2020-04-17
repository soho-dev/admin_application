class DecisionService

  class << self
    def get_decision(application)
      begin
        connection.post(path: "/api/v1/decisions",
                          body: application.to_json,
                          headers: { "Content-Type" => "application/json",
                                     "Api-Token" => api_token }
                        )
      rescue StandardError
        Excon::Response.new({ body: "Decision service error", status: 500 })
      end

    end

    def host
      ENV["DECISION_SERVICE_HOST"]
    end

    def api_token
      ENV["DECISION_SERVICE_API_TOKEN"]
    end

    def connection
      Excon.new(host)
    end
  end
end
