class DecisionService

  class << self
    def get_decision(application)
      begin
        # connection.post(path: "/api/v1/decision_check",
        #                   body: application.to_json,
        #                   headers: { "Content-Type" => "application/json",
        #                              "Api-Token" => api_token }
        #                 )
        Excon::Response.new({ body: sample_response.to_json, status: 200 })
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

    def sample_response
      {
          application_id: 1,
          address: {
            street: "123",
            city: "test_city",
            zip: "321",
            state: "test_state",
            county: "test_county"
          },
          applicant: {
            first_name: "abba",
            last_name: "dabba",
            ssn: "123456789",
            salary: "10000"
          },
          loan_amt: "20000",
          final_decision: "eligible",
          decision: [
            {
              rule_name: "credit_rule",
              decision: "eligible",
              reason: "eligible"
            },
            {
              rule_name: "mortagage_rule",
              decision: "decline",
              reason: "mortagage above threshold of 5"
            }
          ],
          funding_options: [
            {
              years: 5,
              interest_rate: 6,
              emi: 100
            },
            {
              years: 10,
              interest_rate: 6,
              emi: 60
            }
          ]
        }
    end
  end
end
