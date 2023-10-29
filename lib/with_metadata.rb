require 'nokogiri'

module Fido
  class WithMetadata
    def initialize(output)
      @output = output
    end

    # TODO: Rethink output interface to avoid double processing stream
    def save(content, source:)
      @output.save(content, source:).tap do |metadata|
        metadata.merge!(tag_metadata(content))
        puts format_output(source, metadata:)
      end
    end

    private

    # TODO: Keep buffer to prevent chunk splits interfering with count
    def tag_metadata(content)
      images_count = 0
      links_count = 0
      content.each do |chunk|
        doc = Nokogiri::HTML(chunk)
        images_count += doc.css('img').length
        links_count += doc.css('a').length
      end
      { images_count:, links_count: }
    end

    def format_output(source, metadata:)
      <<~METADATA

        site:          #{source}
        images count:  #{metadata.fetch(:images_count)}
        links count:   #{metadata.fetch(:links_count)}
        last fetch:    #{metadata.fetch(:last_fetched_at)}

      METADATA
    end
  end
end
