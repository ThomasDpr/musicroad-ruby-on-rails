class FestivalsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @festivals = Festival.all
    params[:query].present? ? @festivals = @festivals.where("title ILIKE ?", "%#{params[:query]}%") : @festivals
  end
   
  def show
    @festival = Festival.find(params[:id])
  end
end
