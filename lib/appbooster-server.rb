require_relative 'appbooster-server/response'
require_relative 'appbooster-server/query_parser'
require_relative 'appbooster-server/server'

module AppBooster
  class HTTPHandler < EventMachine::HTTPServer
    def process_http_request
      puts  @query_string
      response = EM::HttpResponse.new(self)
      response.status = 200
      response.content = QueryParser.time_for(@query_string)
      response.content_type 'text/html'
      response.send_response
    end
  end

  class HTTPServer

    DEFAULT_PORT = 3000

    DEFAULT_ADDRESS = '0.0.0.0'

    def self.run(address = DEFAULT_ADDRESS, port = DEFAULT_PORT)
      EM::run do
        EM::start_server(address, port, HTTPHandler)
      end
    end
  end
end
