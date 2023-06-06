class FestivalsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @festivals = Festival.all
    params[:query].present? ? @festivals = @festivals.where("title ILIKE ?", "%#{params[:query]}%") : @festivals
  end
end
