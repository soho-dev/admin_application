class ApplicationController < ActionController::Base
  protect_from_forgery unless: -> { request.format.json? }

  before_action :authenticate_user!, unless: -> { request.format.json? || request.format == '*/*' }
  before_action :authenticate_api_user!, if: -> { request.format.json? || request.format == '*/*'}


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
    rescue JWT::ExpiredSignature, JWT::VerificationError
      respond_to do |format|
        format.json  { render :json => { message: "session expire or invalid access token." }, status: 401 }
      end
    end
  end

end
