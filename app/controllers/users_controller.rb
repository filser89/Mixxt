class UsersController < ApplicationController
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_action :set_user, only: [:edit, :update, :show]

  def edit
  end

  def update
    authorize @user
    # img = user_params[:image_url]
    if user_params[:image].present?
      image_url = upload_img(user_params[:image])
      puts "url => #{image_url}"
      params = user_params
      puts "user params => #{params}"
      params.delete(:image)
      puts "user params => #{params}"
      params.merge!({image_url: image_url})
      puts "user params => #{params}"
      if @user.update(params)
        redirect_to @user
      else
        render :edit
      end
    elsif @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  def show
    authorize @user
  end

  private


  def upload_img(img)
    LC.init :application_id => ENV["APPLICATION_ID"],
            :api_key        => ENV["API_KEY"],
            :quiet     => true
    photo = LC::File.new({
      :body => IO.read(img),
      :local_filename => "parsers.jpg",
      :content_type => "image/jpeg",
    })
    photo.save
    photo.url
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :audd_key, :image_url, :image)
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
