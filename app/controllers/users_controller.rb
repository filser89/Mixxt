class UsersController < ApplicationController
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_action :set_user, only: [:edit, :update, :show]

  def edit
  end

  def update
    authorize @user
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  def show
    authorize @user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :audd_key)
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
