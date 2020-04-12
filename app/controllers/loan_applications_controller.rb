class LoanApplicationsController < ApplicationController

  # before_filter :authenticate_admin
  before_action :set_loan_application, only: [:show, :edit, :update, :destroy]
  def index
    @loan_applications = LoanApplication.page(params[:page]).per(2)
  end

  def new
    @loan_application = LoanApplication.new
  end

  def create
    @loan_application = LoanApplication.new(loan_application_params)

    respond_to do |format|
      if @loan_application.save
        format.html { redirect_to loan_applications_path, notice: 'LoanApplication was successfully created.' }
        format.json { render :show, status: :created, location: @loan_application }
      else
        format.html { render :new }
        format.json { render json: @loan_application.errors, status: :unprocessable_entity }
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
        format.html { redirect_to loan_applications_path, notice: 'LoanApplication was successfully updated.' }
        format.json { render :show, status: :ok, location: @loan_application }
      else
        format.html { render :edit }
        format.json { render json: @loan_application.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @loan_application.destroy
    respond_to do |format|
      format.html { redirect_to loan_applications_url, notice: 'LoanApplication was successfully destroyed.' }
      format.json { head :no_content }
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
          format.html{ redirect_to loan_applications_path, alert: "Address not eligible."}
        end
      else
        format.html{ redirect_to loan_applications_path, alert: "Location service error"}
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
