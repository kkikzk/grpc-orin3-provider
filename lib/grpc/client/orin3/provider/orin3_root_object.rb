require_relative '../../../../../gen/Design.ORiN3.Common/V1/orin3_common_pb'
require_relative '../../../../../gen/Message.ORiN3.Provider/V1/orin3_root_object_pb'
require_relative '../../../../../gen/Message.ORiN3.Provider/V1/orin3_root_object_services_pb'
require_relative '../message_client_error'
require_relative 'orin3_base_object'

module O3P
  include Message::ORiN3::Provider::V1::AutoGenerated
end

module O3
  include Design::ORiN3::Common::V1::AutoGenerated
  include Message::ORiN3::Provider::V1::AutoGenerated::RootObject
end

module Grpc
  module Client
    module ORiN3
      module Provider
        class ORiN3RootObject < ORiN3BaseObject
          class RootObjectInformation
            attr_reader :orin3_provider_config, :connection_count

            def initialize(orin3_provider_config, connection_count)
              @orin3_provider_config = orin3_provider_config
              @connection_count = connection_count
            end
          end

          def self.attach(channel)
            begin
              root = O3::RootObjectService::Stub.new(nil, :this_channel_is_insecure, channel_override: channel)
              request = O3::GetRootObjectIdRequest.new(common: O3P::CommonRequest.new)
              response = root.get_root_object_id(request)
              if (response.common.result_code != :SUCCEEDED)
                raise MessageClientError.new(response.common.result_code, response.common.detail)
              end
              return ORiN3RootObject.new(channel, response.root_object_id)
            rescue MessageClientError
              raise
            rescue StandardError => e
              raise MessageClientError.new(e)
            end
          end

          def get_information
            begin
              root = O3::RootObjectService::Stub.new(nil, :this_channel_is_insecure, channel_override: @channel)
              request = O3::GetInformationRequest.new(common: O3P::CommonRequest.new)
              response = root.get_information(request)
              if (response.common.result_code != :SUCCEEDED)
                raise MessageClientError.new(response.common.result_code, response.common.detail)
              end
              return RootObjectInformation.new(response.orin3_provider_config, response.connection_count)
            rescue MessageClientError
              raise
            rescue StandardError => e
              raise MessageClientError.new(e)
            end
          end

          def shutdown
            begin
              root = O3::RootObjectService::Stub.new(nil, :this_channel_is_insecure, channel_override: @channel)
              request = O3::ShutdownRequest.new(common: O3P::CommonRequest.new)
              response = root.shutdown(request)
              if (response.common.result_code != :SUCCEEDED)
                raise MessageClientError.new(response.common.result_code, response.common.detail)
              end
            rescue MessageClientError
              raise
            rescue StandardError => e
              raise MessageClientError.new(e)
            end
          end

          private
          def initialize(channel, internal_id)
            super(channel, internal_id)
          end
        end
      end
    end
  end
end