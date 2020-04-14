class UsersController < ApplicationController
  # skip_before_action :authenticate_api_user!
  before_action :is_admin?, only: [ :create, :new ]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_registration_params)
    @user.password = Devise.friendly_token.first(8)
    respond_to do |format|
      if @user.valid?
        @user.save
        format.html { redirect_to users_path, notice: 'User was successfully created.' }
      else
        format.html { render :new, notice: @user.errors }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  def edit

  end

  def update

  end

  def destroy

  end

  private
  def user_registration_params
    params.require(:user).permit(:first_name, :last_name, :email, :contact, :password, :password_confirmation, :role)
  end
end
