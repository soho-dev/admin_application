class LoanApplication < ApplicationRecord

  belongs_to :address
  has_many :application_decisions

  attr_encrypted :ssn, key: ENV["ENCRYPTION_KEY"]

  before_create :initial_status

  def initial_status
    self.status = "pending"
  end

  def to_hash
    {
      :application_id => self.id,
      :first_name => self.first_name,
      :last_name => self.last_name,
      :date_of_birth => self.date_of_birth,
      :ssn => self.ssn,
      :email => self.email, :phone => self.phone,
      :income => self.income,
      :income_type => self.income_type,
      :requested_loan_amount => self.requested_loan_amount,
      :address => self.address.to_hash
    }
  end

  def last_application_decision
    self.application_decisions.last
  end
end
