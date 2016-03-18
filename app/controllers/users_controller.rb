class UsersController < ApplicationController

  def login
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.save
    session[:user_id] = @user.id
    cookies[:user_id] = @user.id
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end

end
