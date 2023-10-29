require 'nokogiri'

module Fido
  class WithTagStats
    def initialize(output)
      @output = output
    end

    # TODO: Rethink output interface to avoid double processing stream
    def save(content, source:)
      @output.save(content, source:).tap do |metadata|
        metadata.merge!(count_tags(content))
      end
    end

    private

    # TODO: Keep buffer to prevent chunk splits interfering with count
    def count_tags(content)
      images_count = 0
      links_count = 0
      content.each do |chunk|
        doc = Nokogiri::HTML(chunk)
        images_count += doc.css('img').length
        links_count += doc.css('a').length
      end
      { images_count:, links_count: }
    end
  end
end
