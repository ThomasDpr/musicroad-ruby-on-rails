class ChatroomsController < ApplicationController

  def index
    @festivals = Festival.all
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @chatrooms = Chatroom.where(festival: @chatroom.festival)
    @message = Message.new
  end
end
