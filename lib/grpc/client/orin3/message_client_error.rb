module Grpc
  module Client
    module ORiN3
      class MessageClientError < StandardError
        attr_reader :result_code, :detail
  
        def initialize(result_code, detail)
          @result_code = result_code
          @detail = detail
          super(detail)
        end

        def initialize(standard_error)
          @result_code = :UNKNOUN
          @detail = standard_error.message
          super(detail)
        end
      end
    end
  end
end