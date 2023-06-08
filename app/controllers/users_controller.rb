class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.password = BCrypt::Password.create(params["user"]["password"])
    @user.created_at = Time.now
    @user.updated_at = Time.now
   if @user.save
    redirect_to "/"
   else
      @users = User.all
      render :action => 'new'
   end
  end

  def index
    @users = User.all
  end

  def delete
    User.find(params[:username]).destroy
    redirect_to :action => 'index'
  end

  def show
    @user = User.find_by(:username => params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
