class SessionsController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credential(
      params[:user][:email],
      params[:user][:password]
    )

    if @user
      log_in_user!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ['Unable to login']
      render :new
    end
  end

  def destroy
    @user = current_user
    log_out_user!(@user)
    render :new
  end
end
