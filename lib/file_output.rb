module Fido
  class FileOutput
    def initialize(path:, extension: '.html')
      @path = path
      @extension = extension
    end

    def save(content, source:)
      write_to_file(content, filename: format_filename(source))
    end

    private

    def write_to_file(content, filename:)
      File.open(filename, 'w') do |f|
        content.each { |chunk| f.write(chunk) }
      end
    rescue StandardError => e
      File.delete(filename)
      raise e
    end

    # TODO: Rethink filename since website url may be long and contain bad characters
    def format_filename(uri)
      filename = uri.host + uri.path + @extension
      File.join(@path, filename)
    end
  end
end
