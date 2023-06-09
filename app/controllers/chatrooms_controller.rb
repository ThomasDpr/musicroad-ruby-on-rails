class ChatroomsController < ApplicationController

  def index
    @festival = Festival.all
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @chatrooms = Chatroom.where(festival: @chatroom.festival)
  end
end
