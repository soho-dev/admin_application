class DashboardController < ApplicationController

  def index
    @loan_applications = LoanApplication.last(10)
  end
end
