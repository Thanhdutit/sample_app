class SessionsController < ApplicationController
  def new
    cookies[:demo_normal] = "normal "
  end

  def create
    user = User.find_by(email: params.dig(:session, :email)&.downcase)
    if user&.authenticate(params.dig(:session, :password))
      reset_session
      log_in user
      redirect_to user, status: :see_other
    else
      flash.now[:danger] = t("login.err")
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    log_out
    redirect_to root_url, status: :see_other
  end
end