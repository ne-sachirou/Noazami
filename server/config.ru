require 'bundler'
Bundler.require

class Object
  def presence
    present? ? self : nil
  end
end

class String
  def present?
    self != ''
  end
end

class WsApp
  def initialize ws
    @ws = ws
    @ws.on(:open   ) { |evt| on_open    evt }
    @ws.on(:message) { |evt| on_message evt }
    @ws.on(:close  ) { |evt| on_close   evt }
    @ws.on(:error  ) { |evt| on_error   evt }
  end

  def on_open evt
    @thread = Thread.new do
      while true
        sleep rand 3..13
        sentence = %w{マジで ヤバい ウケるー}.sample
        puts "> #{sentence}"
        @ws.send sentence
      end
    end
  end

  def on_message evt
    puts "#{evt.data} <"
  end

  def on_close evt
    @thread.kill
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
      filename = env['REQUEST_PATH'][1..-1].presence || 'index.html'
      body = open(__dir__ + "/public/#{filename}", &:read).lines
      content_type = case File.extname filename
                     when '.html', '.htm' then 'text/html'
                     when '.css'         then 'text/css'
                     when '.js'          then 'application/javascript'
                     else                    'text/plain'
                     end
      ['200', {'Content-Type' => content_type}, body]
    end
  end
end

run App.new
