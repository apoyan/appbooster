require 'forwardable'

module EventMachine

  class Response
    attr_accessor :headers, :status, :content

    def initialize
      @headers = {}
    end

    def send_response
      send_headers
      send_body
      close_connection_after_writing
    end

    def content_type type
      @headers["Content-type"] = type || 'text/plain'
    end

    private

    def send_headers
      @headers["Content-length"] = content.to_s.bytesize
      data = []
      data << "HTTP/1.1 #{@status || 200}\r\n"
      data += add_headers(@headers)
      data << "\r\n"

      send_data data.join
    end

    def send_body
      send_data((@content || '').to_s)
    end

    def add_headers headers
      headers.map { |k, v| "#{k}: #{v}\r\n" }
    end

  end

  class HttpResponse < Response
    extend Forwardable
    def_delegators :@delegate,
                   :send_data,
                   :close_connection,
                   :close_connection_after_writing

    def initialize delegate
      super()
      @delegate = delegate
    end
  end
end
