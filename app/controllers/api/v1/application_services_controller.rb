module Api
  module V1
    class ApplicationServicesController < ApiApplicationController
      before_action :set_loan_application, only: [:show, :edit, :update, :decision_check]

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
            format.json { render json: @loan_application, status: 200 }
          else
            format.json { render json: @loan_application.errors, status: :unprocessable_entity }
          end
        end
      end

      def show
        respond_to do |format|
          format.json { render json: @loan_application, status: 200 }
        end
      end

      def edit
        @loan_application = LoanApplication.find(params[:id])
      end

      def update
        respond_to do |format|
          if @loan_application.update(loan_application_params)
            format.json { render :show, status: :ok, location: @loan_application }
          else
            format.json { render json: @loan_application.errors, status: :unprocessable_entity }
          end
        end
      end

      def decision_check
        respond_to do |format|
          begin
            @request_payload = @loan_application.to_hash
            @response = DecisionService.get_decision(@request_payload)
            @application_decision = ApplicationDecision.call(@request_payload, @response)
            if @application_decision.present?
              format.json { render json: @application_decision, status: 200 }
            else
              format.json { render json: { message: "Decision Service error" }.to_json, status: 400 }
            end
          rescue StandardError
            format.json { render json: { message: "Decision Service error" }.to_json, status: 500 }
          end
        end
      end

      private

      def set_loan_application
        begin
          @loan_application = LoanApplication.find(params[:id])
        rescue ActiveRecord::RecordNotFound => e
          respond_to do |format|
            format.json { render json: { message: e.message }.to_json, status: 400 }
          end
        end
      end

      def loan_application_params
        params.require(:loan_application).permit(:id, :first_name, :last_name, :date_of_birth, :ssn, :email, :phone, :income, :income_type, :requested_loan_amount, :address_id)
      end
    end
  end
end
