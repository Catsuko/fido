require 'net/http'
require_relative 'fetch_error'

module Fido
  class WebPage
    attr_reader :uri

    def initialize(uri)
      @uri = uri
    end

    def fetch(to:)
      to.save(chunks, source: uri)
    end

    private

    def chunks
      Enumerator.new do |chunks|
        Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
          http.request(Net::HTTP::Get.new(uri)) do |response|
            handle_error(response) unless response.is_a?(Net::HTTPSuccess)

            response.read_body { |chunk| chunks.yield(chunk) }
          end
        end
      end
    end

    def handle_error(response)
      raise FetchError.new(response:)
    end
  end
end
