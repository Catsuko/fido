module Fido
  class FileOutput
    def initialize(path:, extension: '.html')
      @path = path
      @extension = extension
    end

    def save(content, source:)
      File.open(format_filename(source), 'w') do |f|
        content.each { |chunk| f.write(chunk) }
      end
    end

    private

    # TODO: Rethink filename since website url may be long and contain bad characters
    def format_filename(uri)
      filename = uri.host + uri.path + @extension
      File.join(@path, filename)
    end
  end
end
