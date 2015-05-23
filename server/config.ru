require 'bundler'
Bundler.require

class WsApp
  def initialize ws
    @ws = ws
    @ws.on(:open   ) { |evt| on_open    evt }
    @ws.on(:message) { |evt| on_message evt }
    @ws.on(:close  ) { |evt| on_close   evt }
    @ws.on(:error  ) { |evt| on_error   evt }
  end

  def on_open evt
    Thread.new do
      while true
        sleep rand 3..13
        sentance = %w{マジで ヤバい ウケるー}.sample
        puts "> #{sentance}"
        @ws.send sentance
      end
    end
  end

  def on_message evt
    puts "#{evt.data} <"
  end

  def on_close evt
  end

  def on_error evt
  end
end

class App
  def call env
    if Faye::WebSocket.websocket? env
      ws = Faye::WebSocket.new env
      WsApp.new ws
      ws.rack_response
    else
      body = open(__dir__ + '/public/index.html', &:read).lines
      ['200', {'Content-Type' => 'text/html'}, body]
    end
  end
end

run App.new
