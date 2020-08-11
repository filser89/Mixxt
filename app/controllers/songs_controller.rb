class SongsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create, :display_global]

  def create

  end

  def display_global

  end

  def display_favorites

  end

  def display_history

  end
end
