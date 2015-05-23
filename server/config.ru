require 'bundler'
Bundler.require

class App
  def call env
    # pp env
    if Faye::WebSocket.websocket? env
      ws = Faye::WebSocket.new env
      ws.on :open do |evt|
        puts 'OPEN'
        # pp evt
      end
      ws.on :message do |evt|
        puts 'MESSAGE'
        # pp evt
        ws.send "You said #{evt.data}"
      end
      ws.on :close do |evt|
        puts 'CLOSE'
        # pp evt
      end
      ws.on :error do |evt|
        puts 'ERROR'
        # pp evt
      end
      ws.rack_response
    else
      body = open(__dir__ + '/public/index.html', &:read).lines
      ['200', {'Content-Type' => 'text/html'}, body]
    end
  end
end

run App.new
