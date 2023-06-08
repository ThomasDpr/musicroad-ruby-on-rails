require 'rspotify'
RSpotify::authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_CLIENT_SECRET'])

class FestivalsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @festivals = Festival.all
    params[:query].present? ? @festivals = @festivals.where("name ILIKE ?", "%#{params[:query]}%") : @festivals
  end

  def show
    @festival = Festival.find(params[:id])
    @artists_name = @festival.artists.first(4).map(&:name)
    @artists_picture = @artists_name.map { |artist| RSpotify::Artist.search(artist).first.images.first["url"] }
  end
end
