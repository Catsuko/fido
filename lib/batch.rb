require 'async'

module Fido
  class Batch
    def initialize(inputs)
      @inputs = inputs
    end

    def fetch(to:)
      Async do
        @inputs.each do |input|
          Async { input.fetch(to:) }
        end
      end
    end
  end
end
