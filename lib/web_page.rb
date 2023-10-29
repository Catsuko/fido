require 'net/http'

module Fido
  class WebPage
    attr_reader :uri

    def initialize(uri)
      @uri = uri
    end

    def fetch(&)
      chunks.each(&)
    end

    def send_to(output)
      output.consume(chunks)
    end

    private

    def chunks
      Enumerator.new do |chunks|
        Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
          http.request(Net::HTTP::Get.new(uri)) do |response|
            raise 'TODO: Handle error!' unless response.is_a?(Net::HTTPSuccess)

            response.read_body { |chunk| chunks.yield(chunk) }
          end
        end
      end
    end
  end
end
