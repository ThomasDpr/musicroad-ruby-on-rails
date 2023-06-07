class FestivalsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @festivals = Festival.all
  end

  def show
    @festival = Festival.find(params[:id])
    @artists = @festival.artists
  end
end
