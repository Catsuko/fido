module Fido
  class FileOutput
    def initialize(path:, extension: '.html')
      @path = path
      @extension = extension
    end

    def save(content, source:)
      { last_fetched_at: write_to_file(content, filename: format_filename(source)) }
    end

    private

    def write_to_file(content, filename:)
      last_modified_at = check_modified_at(filename)
      File.open(filename, 'w') do |f|
        content.each { |chunk| f.write(chunk) }
      end
      last_modified_at || check_modified_at(filename)
    rescue StandardError => e
      File.delete(filename)
      raise e
    end

    # TODO: Improve dumped filename since may contain other bad characters or be too long
    def format_filename(uri)
      filename = uri.host + uri.path + @extension
      filename.gsub!(%r{[\\/]}, '-')
      File.join(@path, filename)
    end

    def check_modified_at(filename)
      File.mtime(filename)
    rescue StandardError
      nil
    end
  end
end
