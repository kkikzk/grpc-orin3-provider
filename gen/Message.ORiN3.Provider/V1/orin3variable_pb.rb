# frozen_string_literal: true
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: Message.ORiN3.Provider/V1/orin3variable.proto

require 'google/protobuf'

require_relative '../../Message.ORiN3.Common/V1/orin3common_pb'


descriptor_data = "\n-Message.ORiN3.Provider/V1/orin3variable.proto\x1a)Message.ORiN3.Common/V1/orin3common.proto\"]\n\x0fGetValueRequest\x12+\n\x06\x63ommon\x18\x01 \x01(\x0b\x32\x1b.ORiN3.Common.CommonRequest\x12\n\n\x02id\x18\x02 \x01(\x0c\x12\x11\n\tvalueType\x18\x03 \x01(\x05\"i\n\x10GetValueResponse\x12,\n\x06\x63ommon\x18\x01 \x01(\x0b\x32\x1c.ORiN3.Common.CommonResponse\x12\'\n\x05value\x18\x02 \x01(\x0b\x32\x18.ORiN3.Common.ORiN3Value\"s\n\x0fSetValueRequest\x12+\n\x06\x63ommon\x18\x01 \x01(\x0b\x32\x1b.ORiN3.Common.CommonRequest\x12\n\n\x02id\x18\x02 \x01(\x0c\x12\'\n\x05value\x18\x03 \x01(\x0b\x32\x18.ORiN3.Common.ORiN3Value\"@\n\x10SetValueResponse\x12,\n\x06\x63ommon\x18\x01 \x01(\x0b\x32\x1c.ORiN3.Common.CommonResponse2s\n\x0fVariableService\x12/\n\x08GetValue\x12\x10.GetValueRequest\x1a\x11.GetValueResponse\x12/\n\x08SetValue\x12\x10.SetValueRequest\x1a\x11.SetValueResponseBk\xaa\x02\x30Message.ORiN3.Provider.V1.AutoGenerated.Variable\xea\x02\x35Message::ORiN3::Provider::V1::AutoGenerated::Variableb\x06proto3"

pool = Google::Protobuf::DescriptorPool.generated_pool
pool.add_serialized_file(descriptor_data)

module Message
  module ORiN3
    module Provider
      module V1
        module AutoGenerated
          module Variable
            GetValueRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("GetValueRequest").msgclass
            GetValueResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("GetValueResponse").msgclass
            SetValueRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("SetValueRequest").msgclass
            SetValueResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("SetValueResponse").msgclass
          end
        end
      end
    end
  end
end
