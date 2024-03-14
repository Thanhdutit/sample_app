class SessionsController < ApplicationController
  before_action :load_user, only: :create
  before_action :authenticate_user, only: :create

  def create
    forwarding_url = session[:forwarding_url]
    reset_session
    log_in @user
    params[:session][:remember_me] == "1" ? remember(@user) : forget(@user)
    redirect_to forwarding_url || @user
  end

  def destroy
    log_out
    redirect_to root_url, status: :see_other
  end

  private

  def load_user
    @user = User.find_by email: params.dig(:session, :email)&.downcase
    return if @user

    flash.now[:danger] = t("login.err_email")
    render :new, status: :unprocessable_entity
  end

  def authenticate_user
    return if @user.try(:authenticate, params.dig(:session, :password))

    flash.now[:danger] = t("login.err_password")
    render :new, status: :unprocessable_entity
  end
end
