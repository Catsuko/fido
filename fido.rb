require 'uri'
require_relative 'lib/web_page'
require_relative 'lib/file_output'

file_output = Fido::FileOutput.new
web_page = Fido::WebPage.new(URI.parse(ARGV[0]))
begin
  web_page.fetch(to: file_output)
rescue StandardError => e
  puts e.message
end
