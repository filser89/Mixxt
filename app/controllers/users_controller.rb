class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  def edit
  end

  def update
  end

  def show
  end

  private

  def set_user
    @user = current_user
  end
end
