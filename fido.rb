require 'uri'
require_relative 'lib/batch'
require_relative 'lib/file_output'
require_relative 'lib/printed_output'
require_relative 'lib/web_page'
require_relative 'lib/with_metadata'

output = Fido::FileOutput.new(path: __dir__)
output = Fido::WithMetadata.new(output) if ARGV.delete('--metadata')
output = Fido::PrintedOutput.new(output)
pages = ARGV.map { |arg| Fido::WebPage.new(URI.parse(arg)) }
Fido::Batch.new(pages).fetch(to: output)
