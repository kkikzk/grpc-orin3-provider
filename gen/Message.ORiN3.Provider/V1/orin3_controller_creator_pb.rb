# frozen_string_literal: true
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: Message.ORiN3.Provider/V1/orin3_controller_creator.proto

require 'google/protobuf'

require_relative './../../Message.ORiN3.Provider/V1/orin3_common_type_pb'


descriptor_data = "\n8Message.ORiN3.Provider/V1/orin3_controller_creator.proto\x12\x16Message.ORiN3.Provider\x1a\x31Message.ORiN3.Provider/V1/orin3_common_type.proto\"\x94\x01\n\x17\x43reateControllerRequest\x12\x35\n\x06\x63ommon\x18\x01 \x01(\x0b\x32%.Message.ORiN3.Provider.CommonRequest\x12\x11\n\tparent_id\x18\x02 \x01(\x0c\x12\x0c\n\x04name\x18\x03 \x01(\t\x12\x11\n\ttype_name\x18\x04 \x01(\t\x12\x0e\n\x06option\x18\x05 \x01(\t\"x\n\x18\x43reateControllerResponse\x12\x36\n\x06\x63ommon\x18\x01 \x01(\x0b\x32&.Message.ORiN3.Provider.CommonResponse\x12\n\n\x02id\x18\x02 \x01(\x0c\x12\x18\n\x10\x63reated_datetime\x18\x03 \x01(\x03\x32\x91\x01\n\x18\x43ontrollerCreatorService\x12u\n\x10\x43reateController\x12/.Message.ORiN3.Provider.CreateControllerRequest\x1a\x30.Message.ORiN3.Provider.CreateControllerResponseB}\xaa\x02\x39Message.ORiN3.Provider.V1.AutoGenerated.ControllerCreator\xea\x02>Message::ORiN3::Provider::V1::AutoGenerated::ControllerCreatorb\x06proto3"

pool = Google::Protobuf::DescriptorPool.generated_pool
pool.add_serialized_file(descriptor_data)

module Message
  module ORiN3
    module Provider
      module V1
        module AutoGenerated
          module ControllerCreator
            CreateControllerRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.CreateControllerRequest").msgclass
            CreateControllerResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.CreateControllerResponse").msgclass
          end
        end
      end
    end
  end
end
