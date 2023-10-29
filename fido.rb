require 'uri'
require_relative 'lib/web_page'

web_page = Fido::WebPage.new(URI.parse(ARGV[0]))
begin
  web_page.fetch do |chunk|
    puts '-' * 50
    puts chunk
    puts '-' * 50
  end
rescue StandardError => e
  puts e.message
end
