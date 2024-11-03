# frozen_string_literal: true
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: V1/orin3_base_object.proto

require 'google/protobuf'

require 'Design.ORiN3.Provider/V1/orin3_object_type_pb'
require 'V1/orin3_common_type_pb'


descriptor_data = "\n\x1aV1/orin3_base_object.proto\x12\x16Message.ORiN3.Provider\x1a\x30\x44\x65sign.ORiN3.Provider/V1/orin3_object_type.proto\x1a\x1aV1/orin3_common_type.proto\"Y\n\x14GetObjectInfoRequest\x12\x35\n\x06\x63ommon\x18\x01 \x01(\x0b\x32%.Message.ORiN3.Provider.CommonRequest\x12\n\n\x02id\x18\x02 \x01(\x0c\"\xe6\x01\n\x15GetObjectInfoResponse\x12\x36\n\x06\x63ommon\x18\x01 \x01(\x0b\x32&.Message.ORiN3.Provider.CommonResponse\x12\x0c\n\x04name\x18\x02 \x01(\t\x12\x11\n\ttype_name\x18\x03 \x01(\t\x12\x0e\n\x06option\x18\x04 \x01(\t\x12\x18\n\x10\x63reated_datetime\x18\x05 \x01(\x03\x12;\n\x0bobject_type\x18\x06 \x01(\x0e\x32&.Design.ORiN3.Provider.ORiN3ObjectType\x12\r\n\x05\x65xtra\x18\x07 \x01(\x05\"U\n\x10GetStatusRequest\x12\x35\n\x06\x63ommon\x18\x01 \x01(\x0b\x32%.Message.ORiN3.Provider.CommonRequest\x12\n\n\x02id\x18\x02 \x01(\x0c\"[\n\x11GetStatusResponse\x12\x36\n\x06\x63ommon\x18\x01 \x01(\x0b\x32&.Message.ORiN3.Provider.CommonResponse\x12\x0e\n\x06status\x18\x02 \x01(\x05\"l\n\rSetTagRequest\x12\x35\n\x06\x63ommon\x18\x01 \x01(\x0b\x32%.Message.ORiN3.Provider.CommonRequest\x12\n\n\x02id\x18\x02 \x01(\x0c\x12\x0b\n\x03key\x18\x03 \x01(\t\x12\x0b\n\x03tag\x18\x04 \x01(\x0c\"H\n\x0eSetTagResponse\x12\x36\n\x06\x63ommon\x18\x01 \x01(\x0b\x32&.Message.ORiN3.Provider.CommonResponse\"_\n\rGetTagRequest\x12\x35\n\x06\x63ommon\x18\x01 \x01(\x0b\x32%.Message.ORiN3.Provider.CommonRequest\x12\n\n\x02id\x18\x02 \x01(\x0c\x12\x0b\n\x03key\x18\x03 \x01(\t\"U\n\x0eGetTagResponse\x12\x36\n\x06\x63ommon\x18\x01 \x01(\x0b\x32&.Message.ORiN3.Provider.CommonResponse\x12\x0b\n\x03tag\x18\x02 \x01(\x0c\"V\n\x11GetTagKeysRequest\x12\x35\n\x06\x63ommon\x18\x01 \x01(\x0b\x32%.Message.ORiN3.Provider.CommonRequest\x12\n\n\x02id\x18\x02 \x01(\x0c\"Z\n\x12GetTagKeysResponse\x12\x36\n\x06\x63ommon\x18\x01 \x01(\x0b\x32&.Message.ORiN3.Provider.CommonResponse\x12\x0c\n\x04keys\x18\x02 \x03(\t\"b\n\x10RemoveTagRequest\x12\x35\n\x06\x63ommon\x18\x01 \x01(\x0b\x32%.Message.ORiN3.Provider.CommonRequest\x12\n\n\x02id\x18\x02 \x01(\x0c\x12\x0b\n\x03key\x18\x03 \x01(\t\"K\n\x11RemoveTagResponse\x12\x36\n\x06\x63ommon\x18\x01 \x01(\x0b\x32&.Message.ORiN3.Provider.CommonResponse2\xdc\x04\n\x11\x42\x61seObjectService\x12l\n\rGetObjectInfo\x12,.Message.ORiN3.Provider.GetObjectInfoRequest\x1a-.Message.ORiN3.Provider.GetObjectInfoResponse\x12`\n\tGetStatus\x12(.Message.ORiN3.Provider.GetStatusRequest\x1a).Message.ORiN3.Provider.GetStatusResponse\x12W\n\x06SetTag\x12%.Message.ORiN3.Provider.SetTagRequest\x1a&.Message.ORiN3.Provider.SetTagResponse\x12W\n\x06GetTag\x12%.Message.ORiN3.Provider.GetTagRequest\x1a&.Message.ORiN3.Provider.GetTagResponse\x12\x63\n\nGetTagKeys\x12).Message.ORiN3.Provider.GetTagKeysRequest\x1a*.Message.ORiN3.Provider.GetTagKeysResponse\x12`\n\tRemoveTag\x12(.Message.ORiN3.Provider.RemoveTagRequest\x1a).Message.ORiN3.Provider.RemoveTagResponseBo\xaa\x02\x32Message.ORiN3.Provider.V1.AutoGenerated.BaseObject\xea\x02\x37Message::ORiN3::Provider::V1::AutoGenerated::BaseObjectb\x06proto3"

pool = Google::Protobuf::DescriptorPool.generated_pool
pool.add_serialized_file(descriptor_data)

module Message
  module ORiN3
    module Provider
      module V1
        module AutoGenerated
          module BaseObject
            GetObjectInfoRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.GetObjectInfoRequest").msgclass
            GetObjectInfoResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.GetObjectInfoResponse").msgclass
            GetStatusRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.GetStatusRequest").msgclass
            GetStatusResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.GetStatusResponse").msgclass
            SetTagRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.SetTagRequest").msgclass
            SetTagResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.SetTagResponse").msgclass
            GetTagRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.GetTagRequest").msgclass
            GetTagResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.GetTagResponse").msgclass
            GetTagKeysRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.GetTagKeysRequest").msgclass
            GetTagKeysResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.GetTagKeysResponse").msgclass
            RemoveTagRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.RemoveTagRequest").msgclass
            RemoveTagResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.RemoveTagResponse").msgclass
          end
        end
      end
    end
  end
end
