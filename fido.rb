# frozen_string_literal: true

require 'uri'
require_relative 'lib/web_page'

web_page = Fido::WebPage.new(URI.parse(ARGV[0]))
web_page.fetch do |chunk|
  puts '-' * 50
  puts chunk
  puts '-' * 50
end
