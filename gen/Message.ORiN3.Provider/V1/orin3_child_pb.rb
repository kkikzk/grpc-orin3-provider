# frozen_string_literal: true
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: Message.ORiN3.Provider/V1/orin3_child.proto

require 'google/protobuf'

require_relative './../../Message.ORiN3.Provider/V1/orin3_common_type_pb'


descriptor_data = "\n+Message.ORiN3.Provider/V1/orin3_child.proto\x12\x16Message.ORiN3.Provider\x1a\x31Message.ORiN3.Provider/V1/orin3_common_type.proto\"R\n\rDeleteRequest\x12\x35\n\x06\x63ommon\x18\x01 \x01(\x0b\x32%.Message.ORiN3.Provider.CommonRequest\x12\n\n\x02id\x18\x02 \x01(\x0c\"H\n\x0e\x44\x65leteResponse\x12\x36\n\x06\x63ommon\x18\x01 \x01(\x0b\x32&.Message.ORiN3.Provider.CommonResponse2g\n\x0c\x43hildService\x12W\n\x06\x44\x65lete\x12%.Message.ORiN3.Provider.DeleteRequest\x1a&.Message.ORiN3.Provider.DeleteResponseBe\xaa\x02-Message.ORiN3.Provider.V1.AutoGenerated.Child\xea\x02\x32Message::ORiN3::Provider::V1::AutoGenerated::Childb\x06proto3"

pool = Google::Protobuf::DescriptorPool.generated_pool
pool.add_serialized_file(descriptor_data)

module Message
  module ORiN3
    module Provider
      module V1
        module AutoGenerated
          module Child
            DeleteRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.DeleteRequest").msgclass
            DeleteResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.DeleteResponse").msgclass
          end
        end
      end
    end
  end
end
