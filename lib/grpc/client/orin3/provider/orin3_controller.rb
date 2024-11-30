require_relative '../../../../../gen/Design.ORiN3.Common/V1/orin3_common_pb'
require_relative '../../../../../gen/Message.ORiN3.Provider/V1/orin3_resource_opener_pb'
require_relative '../../../../../gen/Message.ORiN3.Provider/V1/orin3_resource_opener_services_pb'
require_relative '../../../../../gen/Message.ORiN3.Provider/V1/orin3_child_creator_pb'
require_relative '../../../../../gen/Message.ORiN3.Provider/V1/orin3_child_creator_services_pb'
require_relative '../../../../../gen/Message.ORiN3.Provider/V1/orin3_variable_pb'
require_relative '../../../../../gen/Message.ORiN3.Provider/V1/orin3_variable_services_pb'
require_relative '../message_client_error'
require_relative 'orin3_base_object'
require_relative 'orin3_variable'
require_relative 'orin3_child_creator'

module O3P
  include Message::ORiN3::Provider::V1::AutoGenerated
end

module O3
  include Design::ORiN3::Common::V1::AutoGenerated
  include Message::ORiN3::Provider::V1::AutoGenerated::ResourceOpener
  include Message::ORiN3::Provider::V1::AutoGenerated::ChildCreator
  include Message::ORiN3::Provider::V1::AutoGenerated::Variable
end

module Grpc
  module Client
    module ORiN3
      module Provider
        class ORiN3Controller < ORiN3BaseObject
          include ORiN3ChildCreator
          attr_reader :created_datetime

          def initialize(channel, internal_id, created_datetime)
            @created_datetime = created_datetime
            super(channel, internal_id)
          end

          def open(argument)
            begin
              controller = O3::ResourceOpenerService::Stub.new(nil, :this_channel_is_insecure, channel_override: @channel)
              request = O3::OpenRequest.new(common: O3P::CommonRequest.new, id: @internal_id, argument: argument)
              response = controller.open(request)
              if (response.common.result_code != :SUCCEEDED)
                raise MessageClientError.new(response.common.result_code, response.common.detail)
              end
            rescue MessageClientError
              raise
            rescue StandardError => e
              raise MessageClientError.new(e)
            end            
          end

          def close(argument)
            begin
              controller = O3::ResourceOpenerService::Stub.new(nil, :this_channel_is_insecure, channel_override: @channel)
              request = O3::CloseRequest.new(common: O3P::CommonRequest.new, id: @internal_id, argument: argument)
              response = controller.close(request)
              if (response.common.result_code != :SUCCEEDED)
                raise MessageClientError.new(response.common.result_code, response.common.detail)
              end
            rescue MessageClientError
              raise
            rescue StandardError => e
              raise MessageClientError.new(e)
            end            
          end
        end
      end
    end
  end
end