class FavoritesController < ApplicationController
  def index
    @favorites = Favorite.where(user: current_user)
  end

  def create
    @festival = Festival.find(params[:festival_id])
    @user = current_user
    @favorite = Favorite.new(festival: @festival, user: @user)

    if @favorite.save
      flash[:notice] = "#{@festival.name.capitalize} a été ajouté à vos favoris ✅"
      redirect_to festival_path(@festival)
    else
      render 'festivals/show'
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy
    flash[:alert] = "#{@favorite.festival.name} a été supprimé de vos favoris ❌"
    redirect_to request.fullpath, status: :see_other
  end
end
