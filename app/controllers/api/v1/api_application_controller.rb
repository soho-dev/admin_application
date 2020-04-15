module Api
  module V1
    class ApiApplicationController < ActionController::Base
      respond_to :json
      before_action :authenticate_api_user!


      def authenticate_api_user!
        begin
          decode = JsonWebToken.decode(request.env["HTTP_ACCESS_TOKEN"])
          user = User.find_by_email(decode["email"])
          if user.present?
            return true
          else
            respond_to do |format|
              format.json  { render :json => { message: "session expire or invalid access token." }, status: 401 }
            end
          end
        rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
          respond_to do |format|
            format.json  { render :json => { message: "session expire or invalid access token." }, status: 401 }
          end
        end
      end
    end
  end
end
