# frozen_string_literal: true
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: Message.ORiN3.Provider/V1/orin3_job.proto

require 'google/protobuf'

require_relative './../../Message.ORiN3.Provider/V1/orin3_common_type_pb'


descriptor_data = "\n)Message.ORiN3.Provider/V1/orin3_job.proto\x12\x16Message.ORiN3.Provider\x1a\x31Message.ORiN3.Provider/V1/orin3_common_type.proto\"]\n\x18GetStandardOutputRequest\x12\x35\n\x06\x63ommon\x18\x01 \x01(\x0b\x32%.Message.ORiN3.Provider.CommonRequest\x12\n\n\x02id\x18\x02 \x01(\x0c\"c\n\x19GetStandardOutputResponse\x12\x36\n\x06\x63ommon\x18\x01 \x01(\x0b\x32&.Message.ORiN3.Provider.CommonResponse\x12\x0e\n\x06output\x18\x02 \x01(\t\"\\\n\x17GetStandardErrorRequest\x12\x35\n\x06\x63ommon\x18\x01 \x01(\x0b\x32%.Message.ORiN3.Provider.CommonRequest\x12\n\n\x02id\x18\x02 \x01(\x0c\"a\n\x18GetStandardErrorResponse\x12\x36\n\x06\x63ommon\x18\x01 \x01(\x0b\x32&.Message.ORiN3.Provider.CommonResponse\x12\r\n\x05\x65rror\x18\x02 \x01(\t\"U\n\x10GetResultRequest\x12\x35\n\x06\x63ommon\x18\x01 \x01(\x0b\x32%.Message.ORiN3.Provider.CommonRequest\x12\n\n\x02id\x18\x02 \x01(\x0c\"s\n\x11GetResultResponse\x12\x36\n\x06\x63ommon\x18\x01 \x01(\x0b\x32&.Message.ORiN3.Provider.CommonResponse\x12\x0e\n\x06result\x18\x02 \x01(\x0c\x12\x16\n\x0eis_null_result\x18\x03 \x01(\x08\x32\xdf\x02\n\nJobService\x12x\n\x11GetStandardOutput\x12\x30.Message.ORiN3.Provider.GetStandardOutputRequest\x1a\x31.Message.ORiN3.Provider.GetStandardOutputResponse\x12u\n\x10GetStandardError\x12/.Message.ORiN3.Provider.GetStandardErrorRequest\x1a\x30.Message.ORiN3.Provider.GetStandardErrorResponse\x12`\n\tGetResult\x12(.Message.ORiN3.Provider.GetResultRequest\x1a).Message.ORiN3.Provider.GetResultResponseBa\xaa\x02+Message.ORiN3.Provider.V1.AutoGenerated.Job\xea\x02\x30Message::ORiN3::Provider::V1::AutoGenerated::Jobb\x06proto3"

pool = Google::Protobuf::DescriptorPool.generated_pool
pool.add_serialized_file(descriptor_data)

module Message
  module ORiN3
    module Provider
      module V1
        module AutoGenerated
          module Job
            GetStandardOutputRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.GetStandardOutputRequest").msgclass
            GetStandardOutputResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.GetStandardOutputResponse").msgclass
            GetStandardErrorRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.GetStandardErrorRequest").msgclass
            GetStandardErrorResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.GetStandardErrorResponse").msgclass
            GetResultRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.GetResultRequest").msgclass
            GetResultResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.GetResultResponse").msgclass
          end
        end
      end
    end
  end
end
