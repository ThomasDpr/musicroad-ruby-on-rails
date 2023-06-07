require 'rspotify'
RSpotify::authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_CLIENT_SECRET'])

class ArtistsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def show
    @artist = Artist.find(params[:id])
    @spotify = RSpotify::Artist.search(@artist.name).first
    @top_tracks = @spotify.top_tracks(:fr).first(5)
    @genres =  @spotify.genres.join(" #")
    @albums =  @spotify.albums.first(4)
  end
end
