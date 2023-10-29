module Fido
  class FileOutput
    def initialize(path: nil, extension: '.html')
      @path = path
      @extension = extension
    end

    def save(content, source:)
      filename = File.join(@path || __dir__, source.host + source.path + @extension)
      File.open(filename, 'w') do |f|
        content.each { |chunk| f.write(chunk) }
      end
    end
  end
end
