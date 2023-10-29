require 'uri'
require_relative 'lib/inputs/batch'
require_relative 'lib/inputs/web_page'
require_relative 'lib/outputs/file_output'
require_relative 'lib/outputs/printed_output'
require_relative 'lib/outputs/with_tag_stats'

module Fido
  def self.fetch(urls, include_metadata: false)
    output = FileOutput.new(path: File.join(__dir__, 'fetches'))
    output = WithTagStats.new(output) if include_metadata
    output = PrintedOutput.new(output, include_metadata:)

    pages = urls.map { |url| WebPage.new(URI.parse(url)) }
    Batch.new(pages).fetch(to: output)
  end
end
