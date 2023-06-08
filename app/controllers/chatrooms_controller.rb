class ChatroomsController < ApplicationController

  def index
    @festivals = Festival.all
  end

  def show
    @chatroom = Chatroom.find(params[:id])
  end
end
