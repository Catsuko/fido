require 'nokogiri'

module Fido
  class PrintedMetadata
    def initialize(output)
      @output = output
    end

    # TODO: Keep buffer to prevent chunk splits interfering with count
    # TODO: Track last fetch time
    def save(content, source:)
      print_metadata(content, source:)
      @output.save(content, source:)
    end

    private

    # TODO: Rethink output interface so metadata can be gathered as the response is streamed
    def print_metadata(content, source:)
      image_count = 0
      link_count = 0
      content.each do |chunk|
        doc = Nokogiri::HTML(chunk)
        image_count += doc.css('img').length
        link_count += doc.css('a').length
      end
      puts format_metadata(source, image_count:, link_count:)
    end

    def format_metadata(source, image_count:, link_count:)
      <<~METADATA

        site:          #{source}
        images count:  #{image_count}
        links count:   #{link_count}

      METADATA
    end
  end
end
