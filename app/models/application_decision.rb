class ApplicationDecision < ApplicationRecord
  belongs_to :loan_application

  attr_encrypted :request, key: ENV["ENCRYPTION_KEY"]
  attr_encrypted :response, key: ENV["ENCRYPTION_KEY"]

  after_save :set_application_status

  class << self
    def call(payload, response)
      if response.status == 200
        parsed_response = response_parser(response.body)
        create_application_decision(payload, parsed_response)
      else
        { message: response.body, status: response.status }
      end
    end

    def response_parser(response_body)
      JSON.parse(response_body)
    end

    def create_application_decision(request_body, response_body)
      create(loan_application_id: response_body["application_id"], request: request_body.to_json, response: response_body.to_json, decision: response_body["final_decision"])
    end
  end

  def set_application_status
    self.loan_application.update(status: "approved") if self.decision == "eligible"
    self.loan_application.update(status: "rejected") if self.decision == "decline"
  end

  def parsed_response
    JSON.parse(self.response)
  end

  def parsed_request
    JSON.parse(self.request)
  end
end
