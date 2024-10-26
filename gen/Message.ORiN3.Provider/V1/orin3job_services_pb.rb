# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: Message.ORiN3.Provider/V1/orin3job.proto for package 'Message.ORiN3.Provider.V1.AutoGenerated.Job'

require 'grpc'
require_relative 'orin3job_pb'

module Message
  module ORiN3
    module Provider
      module V1
        module AutoGenerated
          module Job
            module JobService
              class Service

                include ::GRPC::GenericService

                self.marshal_class_method = :encode
                self.unmarshal_class_method = :decode
                self.service_name = 'JobService'

                rpc :GetStandardOutput, ::Message::ORiN3::Provider::V1::AutoGenerated::Job::GetStandardOutputRequest, ::Message::ORiN3::Provider::V1::AutoGenerated::Job::GetStandardOutputResponse
                rpc :GetStandardError, ::Message::ORiN3::Provider::V1::AutoGenerated::Job::GetStandardErrorRequest, ::Message::ORiN3::Provider::V1::AutoGenerated::Job::GetStandardErrorResponse
                rpc :GetResult, ::Message::ORiN3::Provider::V1::AutoGenerated::Job::GetResultRequest, ::Message::ORiN3::Provider::V1::AutoGenerated::Job::GetResultResponse
              end

              Stub = Service.rpc_stub_class
            end
          end
        end
      end
    end
  end
end
