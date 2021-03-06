class UsersController < ApplicationController
  before_action :authenticate_admin

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_registration_params)
    @user.password = "12345678"
    respond_to do |format|
      if @user.valid?
        @user.save
        format.html { redirect_to users_path, notice: 'User was successfully created.' }
      else
        format.html { render :new, notice: @user.errors }
      end
    end
  end


  private
  def user_registration_params
    params.require(:user).permit(:first_name, :last_name, :email, :contact, :password, :password_confirmation, :role)
  end
end
