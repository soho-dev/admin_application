class LoanApplication < ApplicationRecord

  attr_encrypted :ssn, key: ENV["ENCRYPTION_KEY"]

  before_create :initial_status

  def initial_status
    self.status = "pending"
  end
end
