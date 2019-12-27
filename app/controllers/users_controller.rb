# frozen_string_literal: true

class UsersController < ApplicationController
   before_action :set_user, only: %i[show]
  # GET /users/new
  def new
    @user = User.new
  end
 def show; end
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: "#{@user.first_name} was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
      end
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation, :email)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
