class ChatroomsController < ApplicationController

  def index
    @favorites = Favorite.where(user: current_user)
    @chatrooms = Chatroom.where(favorite: true)
    @chatrooms = Chatroom.all
    @favorite = Favorite.all
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @chatrooms = Chatroom.where(festival: @chatroom.festival)
    @message = Message.new
  end
end
