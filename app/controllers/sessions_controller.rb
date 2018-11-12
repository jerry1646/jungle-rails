class SessionsController < ApplicationController

  def new
    # @session = User.new
  end

  def create
    if @user = User.authenticate_with_credentials(params[:login][:email], params[:login][:password])
      session[:user_id] = @user.id.to_s
      redirect_to root_path
    else
      render :new
    end

    # @user = User.find_by(email: params[:login][:email].downcase)

    # if @user && @user.authenticate(params[:login][:password])
    #   session[:user_id] = @user.id.to_s
    #   redirect_to root_path
    # else
    #   render :new
    # end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end

end
