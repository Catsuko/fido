require 'uri'
require_relative 'lib/batch'
require_relative 'lib/web_page'
require_relative 'lib/file_output'
require_relative 'lib/printed_output'

output = Fido::PrintedOutput.new(Fido::FileOutput.new(path: __dir__))
pages = ARGV.map { |arg| Fido::WebPage.new(URI.parse(arg)) }
Fido::Batch.new(pages).fetch(to: output)
