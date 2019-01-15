class SessionController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase

    if user&.authenticate(params[:session][:password])
      acc_activated user
    else
      acc_no_activated
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  def acc_activated user
    log_in user

    if params[:session][:remember_me] == Settings.one
      remember user
    else
      forget user
    end
    redirect_to user
  end

  def acc_no_activated
    flash.now[:danger] = t ".danger"
    render :new
  end
end
