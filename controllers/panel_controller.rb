class PanelController < ApplicationController

  panel_show = lambda do
    @saved_data = Hash.new([])
    @channels = Channel.all

    @channels.each do |channel|
      @saved_data[channel.name] = Message.where(channels: channel.name).order_by(:created_at => 'desc').limit(30)
    end
    erb :index
  end

  get '/', &panel_show
end