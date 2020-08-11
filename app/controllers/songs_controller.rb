class SongsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create, :display_global]

  def create
    # receive the link
    # understand what app it belongs to
    # check if it is in the DB

    # if Spotify

    # regex to cut out the id
    # make a query to Spotify fot track obj
    # get artist and title
    # make queries to NetEase and QQ in order to get a link
    # create a song with all the attributes from 3 apps track objs
    # make up a msg


    # if Ease Net


    # if QQ
  end

  def display_global

  end

  def display_favorites

  end

  def display_history

  end
end
