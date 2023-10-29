module Fido
  class Batch
    def initialize(inputs)
      @inputs = inputs
    end

    def fetch(to:)
      @inputs.each { |input| input.fetch(to:) }
    end
  end
end
