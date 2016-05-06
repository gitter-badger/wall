class CatcherController < ApplicationController
  catcher_messages = lambda do
    stored_message = Message.create(
      {
        content: params[:text],
        from: params[:phone],
        provider: 'SMS'
      }
    )

    stored_message.channels.each do |channel|
      settings.faye_client.publish("/#{channel}", stored_message.content)
    end
  end

  get '/messages/*', &catcher_messages
  get '/sms/*', &catcher_messages
end
