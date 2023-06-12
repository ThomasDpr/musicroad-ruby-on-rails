require 'rspotify'
RSpotify::authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_CLIENT_SECRET'])

class FestivalsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @festivals = Festival.all

    if params[:festival_filter]
      start_time = params[:festival_filter][:start_time]
      end_time = params[:festival_filter][:end_time]
      @festivals = @festivals.where(start_date: start_time..end_time)
    end

    sql_subquery = "name ILIKE query OR location ILIKE :query"
    params[:query].present? ? @festivals = @festivals.where(sql_subquery, query: "%#{params[:query]}%") : @festivals

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
    @favorite = Favorite.new

    @marker = { lat: @festival.latitude, lng: @festival.longitude,
                info_window_html: render_to_string(partial: "info_window", locals: { festival: @festival }) }
  end
end
