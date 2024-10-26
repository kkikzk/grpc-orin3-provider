# frozen_string_literal: true
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: Message.ORiN3.Provider/V1/orin3file.proto

require 'google/protobuf'

require_relative '../../Message.ORiN3.Common/V1/orin3common_pb'


descriptor_data = "\n)Message.ORiN3.Provider/V1/orin3file.proto\x1a)Message.ORiN3.Common/V1/orin3common.proto\"^\n\x0fReadFileRequest\x12+\n\x06\x63ommon\x18\x01 \x01(\x0b\x32\x1b.ORiN3.Common.CommonRequest\x12\n\n\x02id\x18\x02 \x01(\x0c\x12\x12\n\nbufferSize\x18\x03 \x01(\x05\"P\n\x10ReadFileResponse\x12,\n\x06\x63ommon\x18\x01 \x01(\x0b\x32\x1c.ORiN3.Common.CommonResponse\x12\x0e\n\x06\x62uffer\x18\x02 \x01(\x0c\"p\n\x10WriteFileRequest\x12+\n\x06\x63ommon\x18\x01 \x01(\x0b\x32\x1b.ORiN3.Common.CommonRequest\x12\n\n\x02id\x18\x02 \x01(\x0c\x12\x0e\n\x06\x62uffer\x18\x03 \x01(\x0c\x12\x13\n\x0btotalLength\x18\x04 \x01(\x05\"A\n\x11WriteFileResponse\x12,\n\x06\x63ommon\x18\x01 \x01(\x0b\x32\x1c.ORiN3.Common.CommonResponse\"\x87\x01\n\x0fSeekFileRequest\x12+\n\x06\x63ommon\x18\x01 \x01(\x0b\x32\x1b.ORiN3.Common.CommonRequest\x12\n\n\x02id\x18\x02 \x01(\x0c\x12\x0e\n\x06offset\x18\x03 \x01(\x03\x12+\n\x06origin\x18\x04 \x01(\x0e\x32\x1b.ORiN3MessageFileSeekOrigin\"R\n\x10SeekFileResponse\x12,\n\x06\x63ommon\x18\x01 \x01(\x0b\x32\x1c.ORiN3.Common.CommonResponse\x12\x10\n\x08position\x18\x02 \x01(\x03\"M\n\x12\x43\x61nReadFileRequest\x12+\n\x06\x63ommon\x18\x01 \x01(\x0b\x32\x1b.ORiN3.Common.CommonRequest\x12\n\n\x02id\x18\x02 \x01(\x0c\"T\n\x13\x43\x61nReadFileResponse\x12,\n\x06\x63ommon\x18\x01 \x01(\x0b\x32\x1c.ORiN3.Common.CommonResponse\x12\x0f\n\x07\x63\x61nRead\x18\x02 \x01(\x08\"N\n\x13\x43\x61nWriteFileRequest\x12+\n\x06\x63ommon\x18\x01 \x01(\x0b\x32\x1b.ORiN3.Common.CommonRequest\x12\n\n\x02id\x18\x02 \x01(\x0c\"V\n\x14\x43\x61nWriteFileResponse\x12,\n\x06\x63ommon\x18\x01 \x01(\x0b\x32\x1c.ORiN3.Common.CommonResponse\x12\x10\n\x08\x63\x61nWrite\x18\x02 \x01(\x08\"O\n\x14GetFileLengthRequest\x12+\n\x06\x63ommon\x18\x01 \x01(\x0b\x32\x1b.ORiN3.Common.CommonRequest\x12\n\n\x02id\x18\x02 \x01(\x0c\"U\n\x15GetFileLengthResponse\x12,\n\x06\x63ommon\x18\x01 \x01(\x0b\x32\x1c.ORiN3.Common.CommonResponse\x12\x0e\n\x06length\x18\x02 \x01(\x03\"_\n\x14SetFileLengthRequest\x12+\n\x06\x63ommon\x18\x01 \x01(\x0b\x32\x1b.ORiN3.Common.CommonRequest\x12\n\n\x02id\x18\x02 \x01(\x0c\x12\x0e\n\x06length\x18\x03 \x01(\x03\"E\n\x15SetFileLengthResponse\x12,\n\x06\x63ommon\x18\x01 \x01(\x0b\x32\x1c.ORiN3.Common.CommonResponse*=\n\x1aORiN3MessageFileSeekOrigin\x12\t\n\x05\x42\x65gin\x10\x00\x12\x0b\n\x07\x43urrent\x10\x01\x12\x07\n\x03\x45nd\x10\x02\x32\x82\x03\n\x0b\x46ileService\x12-\n\x04Read\x12\x10.ReadFileRequest\x1a\x11.ReadFileResponse0\x01\x12\x30\n\x05Write\x12\x11.WriteFileRequest\x1a\x12.WriteFileResponse(\x01\x12+\n\x04Seek\x12\x10.SeekFileRequest\x1a\x11.SeekFileResponse\x12\x34\n\x07\x43\x61nRead\x12\x13.CanReadFileRequest\x1a\x14.CanReadFileResponse\x12\x37\n\x08\x43\x61nWrite\x12\x14.CanWriteFileRequest\x1a\x15.CanWriteFileResponse\x12:\n\tGetLength\x12\x15.GetFileLengthRequest\x1a\x16.GetFileLengthResponse\x12:\n\tSetLength\x12\x15.SetFileLengthRequest\x1a\x16.SetFileLengthResponseBc\xaa\x02,Message.ORiN3.Provider.V1.AutoGenerated.File\xea\x02\x31Message::ORiN3::Provider::V1::AutoGenerated::Fileb\x06proto3"

pool = Google::Protobuf::DescriptorPool.generated_pool
pool.add_serialized_file(descriptor_data)

module Message
  module ORiN3
    module Provider
      module V1
        module AutoGenerated
          module File
            ReadFileRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("ReadFileRequest").msgclass
            ReadFileResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("ReadFileResponse").msgclass
            WriteFileRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("WriteFileRequest").msgclass
            WriteFileResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("WriteFileResponse").msgclass
            SeekFileRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("SeekFileRequest").msgclass
            SeekFileResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("SeekFileResponse").msgclass
            CanReadFileRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("CanReadFileRequest").msgclass
            CanReadFileResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("CanReadFileResponse").msgclass
            CanWriteFileRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("CanWriteFileRequest").msgclass
            CanWriteFileResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("CanWriteFileResponse").msgclass
            GetFileLengthRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("GetFileLengthRequest").msgclass
            GetFileLengthResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("GetFileLengthResponse").msgclass
            SetFileLengthRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("SetFileLengthRequest").msgclass
            SetFileLengthResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("SetFileLengthResponse").msgclass
            ORiN3MessageFileSeekOrigin = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("ORiN3MessageFileSeekOrigin").enummodule
          end
        end
      end
    end
  end
end
