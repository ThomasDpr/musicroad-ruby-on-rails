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
        info_window_html: render_to_string(partial: "info_window", locals: { festival: festival }),
        marker_html: render_to_string(partial: "marker")
      }
    end
  end

  def show
    @festival = Festival.find(params[:id])

    @artists = @festival.artists.sort_by { |artist| artist.name }
    @artists_picture = @artists.map do |artist|
      artist.image
    end

    @marker = {
      lat: @festival.latitude,
      lng: @festival.longitude,
      info_window_html: render_to_string(partial: "info_window", locals: { festival: @festival }),
      marker_html: render_to_string(partial: "marker")
    }

    if !user_signed_in? || Favorite.find_by(user: current_user, festival: @festival).nil?
      @favorite = Favorite.new
    else
      @favorite = Favorite.find_by(user: current_user, festival: @festival)
    end
  end
end
