class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  def show
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :audd_key)
  end
end
