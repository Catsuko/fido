module Fido
  class FetchError < StandardError
    attr_reader :response

    def initialize(response:)
      @response = response
      super
    end

    def message
      "Could not fetch `#{response.uri}`: #{response.code} #{response.message}"
    end
  end
end
