class DisplayController < ApplicationController

  channel_chat = lambda do 
    @channel = Channel.find_by(name: params[:channel])
    @saved_data = Message.where(channels: @channel.name).order_by(:created_at => 'desc').limit(10)
    erb :phablet
  end

  channel_screen = lambda do 
    @channel = params[:channel]
    @saved_data = Message.all.order_by(:created_at => 'desc').limit(1)
    erb :screen
  end


  get '/chat/:channel', &channel_chat
  get '/screen/:channel', &channel_screen
end