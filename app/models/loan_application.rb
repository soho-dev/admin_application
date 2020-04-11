class LoanApplication < ApplicationRecord

  attr_encrypted :ssn, key: ENV["ENCRYPTION_KEY"]
end
