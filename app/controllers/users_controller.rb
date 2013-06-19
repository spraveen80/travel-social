class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @itineraries = @user.itineraries
    @page_title = @user.name
  end

  def new
    @user = User.new
    @page_title = "Sign up"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Travel Assistance!"
      redirect_to @user
    else
      @page_title = "Sign up"
      render 'new'
    end
  end
end
