# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: Message.ORiN3.Provider/V1/orin3_child.proto for package 'Message.ORiN3.Provider.V1.AutoGenerated.Child'

require 'grpc'
require_relative './../../Message.ORiN3.Provider/V1/orin3_child_pb'

module Message
  module ORiN3
    module Provider
      module V1
        module AutoGenerated
          module Child
            module ChildService
              class Service

                include ::GRPC::GenericService

                self.marshal_class_method = :encode
                self.unmarshal_class_method = :decode
                self.service_name = 'Message.ORiN3.Provider.ChildService'

                rpc :Delete, ::Message::ORiN3::Provider::V1::AutoGenerated::Child::DeleteRequest, ::Message::ORiN3::Provider::V1::AutoGenerated::Child::DeleteResponse
              end

              Stub = Service.rpc_stub_class
            end
          end
        end
      end
    end
  end
end
