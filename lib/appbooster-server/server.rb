require 'eventmachine'

module EventMachine
  class HTTPServer < EM::P::HeaderAndContentProtocol

    def receive_request(headers, _)
      @http = headers_2_hash headers
      parse_request headers.first
      process_http_request
    end

    def parse_request(line)
      request = line.split(' ')[1]
      @query_string = request.split('?')[1]
    end
  end
end
