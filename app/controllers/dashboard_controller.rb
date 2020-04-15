class DashboardController < ApplicationController

  def index
    @loan_applications = LoanApplication.order("created_at DESC").first(10)
  end
end
