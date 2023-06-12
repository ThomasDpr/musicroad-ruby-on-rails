class FavoritesController < ApplicationController
  def index
    @favorites = Favorite.where(user: current_user)
  end

  def create
    @festival = Festival.find(params[:festival_id])
    @user = current_user
    @favorite = Favorite.new(festival: @festival, user: @user)

    if @favorite.save
      redirect_to festival_path(@festival)
    else
      render 'festivals/show'
    end
  end
end
