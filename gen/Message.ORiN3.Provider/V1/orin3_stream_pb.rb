# frozen_string_literal: true
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: Message.ORiN3.Provider/V1/orin3_stream.proto

require 'google/protobuf'

require_relative './../../Message.ORiN3.Provider/V1/orin3_common_type_pb'


descriptor_data = "\n,Message.ORiN3.Provider/V1/orin3_stream.proto\x12\x16Message.ORiN3.Provider\x1a\x31Message.ORiN3.Provider/V1/orin3_common_type.proto\"P\n\x0bReadRequest\x12\x35\n\x06\x63ommon\x18\x01 \x01(\x0b\x32%.Message.ORiN3.Provider.CommonRequest\x12\n\n\x02id\x18\x02 \x01(\x0c\"U\n\x0cReadResponse\x12\x36\n\x06\x63ommon\x18\x01 \x01(\x0b\x32&.Message.ORiN3.Provider.CommonResponse\x12\r\n\x05value\x18\x02 \x01(\x0c\x32\x64\n\rStreamService\x12S\n\x04Read\x12#.Message.ORiN3.Provider.ReadRequest\x1a$.Message.ORiN3.Provider.ReadResponse0\x01\x42g\xaa\x02.Message.ORiN3.Provider.V1.AutoGenerated.Stream\xea\x02\x33Message::ORiN3::Provider::V1::AutoGenerated::Streamb\x06proto3"

pool = Google::Protobuf::DescriptorPool.generated_pool
pool.add_serialized_file(descriptor_data)

module Message
  module ORiN3
    module Provider
      module V1
        module AutoGenerated
          module Stream
            ReadRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ReadRequest").msgclass
            ReadResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ReadResponse").msgclass
          end
        end
      end
    end
  end
end
