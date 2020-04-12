module Api
  module V1
    class ApplicationServicesController < ApiApplicationController
      before_action :set_loan_application, only: [:show, :edit, :update, :destroy]
      
      def index
        @loan_applications = LoanApplication.all
        respond_to do |format|
          format.json{ render json: @loan_applications, status: 200 }
        end
      end
      def create
        @loan_application = LoanApplication.new(loan_application_params)
        respond_to do |format|
          if @loan_application.save
            format.json { render :show, status: :created, location: @loan_application }
          else
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
            format.html { redirect_to @loan_application, notice: 'LoanApplication was successfully updated.' }
            format.json { render :show, status: :ok, location: @loan_application }
          else
            format.html { render :edit }
            format.json { render json: @loan_application.errors, status: :unprocessable_entity }
          end
        end
      end

      private

      def set_loan_application
        @loan_application = LoanApplication.find(params[:id])
      end

      def loan_application_params
        params.require(:loan_application).permit(:id, :first_name, :last_name, :date_of_birth, :ssn, :email, :phone, :income, :income_type, :requested_loan_amount)
      end
    end
  end
end
