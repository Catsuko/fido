require 'uri'
require_relative 'lib/batch'
require_relative 'lib/file_output'
require_relative 'lib/printed_output'
require_relative 'lib/web_page'
require_relative 'lib/with_tag_stats'

output = Fido::FileOutput.new(path: __dir__)
if (include_metadata = ARGV.delete('--metadata'))
  output = Fido::WithTagStats.new(output)
end
output = Fido::PrintedOutput.new(output, include_metadata:)

pages = ARGV.map { |arg| Fido::WebPage.new(URI.parse(arg)) }
Fido::Batch.new(pages).fetch(to: output)
