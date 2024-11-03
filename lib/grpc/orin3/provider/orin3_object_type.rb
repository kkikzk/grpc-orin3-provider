module Grpc
  module ORiN3
    module Provider
      module ORiN3ObjectType
        ProviderRoot = 0
        Controller = 1
        Module = 2
        Variable = 3
        File = 4
        Stream = 5
        Event = 6
        Job = 7
  
        def self.to_i(type)
          const_get(type)
        rescue NameError
          raise ArgumentError, "Invalid ORiN3ObjectType: #{type}"
        end
  
        def self.from_i(value)
          constants.find { |const| const_get(const) == value }
        end
  
        def self.all
          constants
        end
  
        def self.valid?(value)
          constants.any? { |const| const_get(const) == value }
        end
      end
    end
  end
end