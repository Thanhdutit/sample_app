class UsersController < ApplicationController
  def show
    @user = User.find_by id: params[:id]
    return if @user

    flash[:warning] = "Not found user!"
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      # something
      flash[:success] = t("error.messages")
      redirect_to @user, status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
                                 :password_confirmation
  end
end
