class LoanApplicationsController < ApplicationController

  before_action :authenticate_admin

  before_action :set_loan_application, only: [:show, :edit, :update]
  def index
    statuses = %w[pending approved rejected]
    search_params = %w[pending approved rejected] & [params[:status_search]] if params[:status_search].present?
    @loan_applications = LoanApplication.where(status: search_params.present? ? search_params : statuses).order("created_at DESC").page(params[:page]).per(20)
  end

  def new
    @loan_application = LoanApplication.new
    @address = Address.find(params[:address_id]) if params[:address_id].present?
  end

  def create
    @loan_application = LoanApplication.new(loan_application_params)
    @address =  params[:address_id].present? ? Address.find(params[:address_id]) : Address.find(@loan_application.address_id)
    respond_to do |format|
      if @loan_application.save
        format.html { redirect_to @loan_application, notice: 'LoanApplication was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def show
    @loan_application = LoanApplication.find(params[:id])
  end

  def edit
    @loan_application = LoanApplication.find(params[:id])
  end

  def update
    respond_to do |format|
      if @loan_application.update(loan_application_params)
        format.html { redirect_to @loan_application, notice: 'LoanApplication was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end



  def decision_check
    respond_to do |format|
      begin
        @loan_application = LoanApplication.find(params[:id])
        @request_payload = @loan_application.to_hash
        @response = DecisionService.get_decision(@request_payload)
        @application_decision = ApplicationDecision.call(@request_payload, @response)
        if @application_decision.present?
          format.html { redirect_to @loan_application,  notice: "Decision done successfully"  }
        else
          format.html { redirect_to @loan_application,  alert: "Decision Service error" }
        end
      rescue StandardError
        format.html {  redirect_to @loan_application,  alert: "Decision Service error"  }
      end
    end
  end

  def address_check
    response = LocationService.get_address_info({address: params["address"]})
    respond_to do |format|
      if response.status == 200
        @address = Address.create_address(response.body)
        if @address.present? && @address.save
          format.html{ redirect_to new_loan_application_path(address_id: @address.id), notice: "Address Eligible" }
        else
          format.html{ redirect_to new_loan_application_path, alert: "Address not eligible." }
        end
      elsif response.status == 404
        format.html{ redirect_to new_loan_application_path, alert: "Address not eligible." }
      else
        format.html{ redirect_to new_loan_application_path, alert: "Location service error." }
      end
    end
  end

  private

  def set_loan_application
    @loan_application = LoanApplication.find(params[:id])
  end

  def loan_application_params
    params.require(:loan_application).permit(:id, :first_name, :last_name, :date_of_birth, :ssn, :email, :phone, :income, :income_type, :requested_loan_amount, :address_id)
  end
end
