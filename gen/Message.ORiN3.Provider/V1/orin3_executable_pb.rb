# frozen_string_literal: true
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: V1/orin3_executable.proto

require 'google/protobuf'

require 'V1/orin3_common_type_pb'


descriptor_data = "\n\x19V1/orin3_executable.proto\x12\x16Message.ORiN3.Provider\x1a\x1aV1/orin3_common_type.proto\"{\n\x0e\x45xecuteRequest\x12\x35\n\x06\x63ommon\x18\x01 \x01(\x0b\x32%.Message.ORiN3.Provider.CommonRequest\x12\n\n\x02id\x18\x02 \x01(\x0c\x12\x14\n\x0c\x63ommand_name\x18\x03 \x01(\t\x12\x10\n\x08\x61rgument\x18\x04 \x01(\x0c\"Y\n\x0f\x45xecuteResponse\x12\x36\n\x06\x63ommon\x18\x01 \x01(\x0b\x32&.Message.ORiN3.Provider.CommonResponse\x12\x0e\n\x06result\x18\x02 \x01(\x0c\x32o\n\x11\x45xecutableService\x12Z\n\x07\x45xecute\x12&.Message.ORiN3.Provider.ExecuteRequest\x1a\'.Message.ORiN3.Provider.ExecuteResponseBo\xaa\x02\x32Message.ORiN3.Provider.V1.AutoGenerated.Executable\xea\x02\x37Message::ORiN3::Provider::V1::AutoGenerated::Executableb\x06proto3"

pool = Google::Protobuf::DescriptorPool.generated_pool
pool.add_serialized_file(descriptor_data)

module Message
  module ORiN3
    module Provider
      module V1
        module AutoGenerated
          module Executable
            ExecuteRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ExecuteRequest").msgclass
            ExecuteResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ExecuteResponse").msgclass
          end
        end
      end
    end
  end
end
