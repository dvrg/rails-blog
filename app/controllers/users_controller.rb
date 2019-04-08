class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    #debugger
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_param)
    if @user.save
      log_in @user
      flash[:success] = "Berhasil register!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private

    def user_param
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
