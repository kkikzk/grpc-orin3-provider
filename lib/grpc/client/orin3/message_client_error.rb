module Grpc
  module Client
    module ORiN3
      class MessageClientError < StandardError
        attr_reader :result_code, :detail, :original_exception
  
        def initialize(arg1, arg2 = nil)
          if arg2.nil? && arg1.is_a?(StandardError)
            @result_code = :UNKNOWN
            @detail = arg1.message
            @original_exception = arg1
            super("Code: #{@result_code}, Detail: #{@detail}")
            set_backtrace(arg1.backtrace)
          else
            @result_code = arg1
            @detail = arg2
            super("Code: #{@result_code}, Detail: #{@detail}")
          end
        end
      end
    end
  end
end