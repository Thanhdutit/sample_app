class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(index edit update destroy)
  before_action :find_user, only: %i(show edit update destroy)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def show
    @user = User.find_by id: params[:id]
    return if @user

    flash[:warning] = t("error.mes_err")
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def destroy
    if @user.destroy
      flash[:success] = t("user.delete_true")
    else
      flash[:danger] = t("user.delete_fail")
    end
    redirect_to users_path
  end

  def create
    @user = User.new user_params
    if @user.save
      # something
      reset_session
      log_in @user
      flash[:success] = t("error.messages")
      redirect_to @user, status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def index
    @pagy, @users = pagy User.all, items: 10
  end

  def update
    if @user.update user_params
      flash[:success] = t("user.update")
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
                                 :password_confirmation
  end

  def find_user
    @user = User.find_by(id: params[:id])
    return if @user

    flash[:alert] = t("error.mes_err")
    redirect_to root_url
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t("user.login")
    redirect_to login_url
  end

  def correct_user
    return if current_user?(@user)

    flash[:error] = t("user.correct")
    redirect_to root_url
  end

  def admin_user
    return if current_user.admin?

    flash[:alert] = t("user.admin")
    redirect_to root_path
  end
end
