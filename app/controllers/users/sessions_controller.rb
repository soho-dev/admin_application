# SessionsController generated by devise_token_authenticatable

class Users::SessionsController < Devise::SessionsController
  skip_before_action :authenticate_api_user!
  def create
    if request.format.json? || request.format == '*/*'
      user = User.find_by_email(params[:user][:email])
      respond_to do |format|
        if user && user.valid_password?(params[:user][:password])
          token = ::JsonWebToken.encode({email: user.email})
          format.json  { render :json => { access_token: token } }
        else
          format.json  { render :json => { message: "invalid email or password" } }
        end
      end
    else
      super
    end
  end
end