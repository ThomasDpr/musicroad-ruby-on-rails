require 'rspotify'

class ArtistsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def show
    @artist = Artist.find(params[:id])
    @spotify = RSpotify::Artist.search(@artist.name).first
  end
end
