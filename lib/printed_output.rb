require_relative 'fetch_error'

module Fido
  class PrintedOutput
    def initialize(output, include_metadata: false)
      @output = output
      @include_metadata = include_metadata
    end

    def save(content, source:)
      metadata = @output.save(content, source:)
      output = "✅ #{source}"
      output += format_metadata(metadata) if @include_metadata
      puts output
    rescue FetchError => e
      puts "❌ #{source} (#{e.response.code} #{e.response.message})"
    end

    private

    def format_metadata(metadata)
      <<-METADATA

      images count:  #{metadata.fetch(:images_count)}
      links count:   #{metadata.fetch(:links_count)}
      last fetch:    #{metadata.fetch(:last_fetched_at)}
      METADATA
    end
  end
end
