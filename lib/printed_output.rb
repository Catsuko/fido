require_relative 'fetch_error'

module Fido
  class PrintedOutput
    def initialize(output)
      @output = output
    end

    def save(content, source:)
      @output.save(content, source:)
      puts "✅ #{source}"
    rescue FetchError => e
      puts "❌ #{source} (#{e.response.code} #{e.response.message})"
    end
  end
end
