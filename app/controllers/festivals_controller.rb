require 'rspotify'
RSpotify::authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_CLIENT_SECRET'])

class FestivalsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @festivals = Festival.all

    # Subquery to match festivals by name or location
    sql_subquery = "name ILIKE :query OR location ILIKE :query"

    # Check if a search query is present and filter festivals by it if it is
    if params[:query].present?
      @festivals = @festivals.where(sql_subquery, query: "%#{params[:query]}%")
    end

    # Check if date filter parameters are present and filter festivals by them if they are
    if params[:festival_filter]
      start_time = DateTime.parse(params[:festival_filter][:start_time]) if params[:festival_filter][:start_time].present?
      end_time = DateTime.parse(params[:festival_filter][:end_time]) if params[:festival_filter][:end_time].present?
      @festivals = @festivals.where(start_date: start_time..end_time)
    end

    @markers = @festivals.geocoded.map do |festival|
      {
        lat: festival.latitude,
        lng: festival.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { festival: festival })
      }
    end
  end

  def show
    @festival = Festival.find(params[:id])
    @artists_name = @festival.artists.first(4).map(&:name)
    @artists_picture = @artists_name.map { |artist| RSpotify::Artist.search(artist).first.images.first["url"] }
    @marker = { lat: @festival.latitude, lng: @festival.longitude, info_window_html: render_to_string(partial: "info_window", locals: { festival: @festival }) }
    if Favorite.find_by(user: current_user, festival: @festival).nil?
      @favorite = Favorite.new
    else
      @favorite = Favorite.find_by(user: current_user, festival: @festival)
    end
  end
end
