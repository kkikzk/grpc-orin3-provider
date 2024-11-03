# frozen_string_literal: true
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: Message.ORiN3.Provider/V1/orin3_common_type.proto

require 'google/protobuf'

require 'Design.ORiN3.Common/V1/orin3_common_pb'
require 'Design.ORiN3.Provider/V1/orin3_value_type_pb'


descriptor_data = "\n1Message.ORiN3.Provider/V1/orin3_common_type.proto\x12\x16Message.ORiN3.Provider\x1a)Design.ORiN3.Common/V1/orin3_common.proto\x1a/Design.ORiN3.Provider/V1/orin3_value_type.proto\"!\n\rCommonRequest\x12\x10\n\x08reserved\x18\x01 \x01(\x05\"V\n\x0e\x43ommonResponse\x12\x34\n\x0bresult_code\x18\x01 \x01(\x0e\x32\x1f.Design.ORiN3.Common.ResultCode\x12\x0e\n\x06\x64\x65tail\x18\x02 \x01(\t\"\xbc\x1b\n\nORiN3Value\x12\x33\n\x04type\x18\x01 \x01(\x0e\x32%.Design.ORiN3.Provider.ORiN3ValueType\x12\x31\n\x04\x62ool\x18\n \x01(\x0b\x32!.Message.ORiN3.Provider.ORiN3BoolH\x00\x12<\n\nbool_array\x18\x0b \x01(\x0b\x32&.Message.ORiN3.Provider.ORiN3BoolArrayH\x00\x12\x42\n\rnullable_bool\x18\x0c \x01(\x0b\x32).Message.ORiN3.Provider.ORiN3NullableBoolH\x00\x12M\n\x13nullable_bool_array\x18\r \x01(\x0b\x32..Message.ORiN3.Provider.ORiN3NullableBoolArrayH\x00\x12\x31\n\x04int8\x18\x14 \x01(\x0b\x32!.Message.ORiN3.Provider.ORiN3Int8H\x00\x12<\n\nint8_array\x18\x15 \x01(\x0b\x32&.Message.ORiN3.Provider.ORiN3Int8ArrayH\x00\x12\x42\n\rnullable_int8\x18\x16 \x01(\x0b\x32).Message.ORiN3.Provider.ORiN3NullableInt8H\x00\x12M\n\x13nullable_int8_array\x18\x17 \x01(\x0b\x32..Message.ORiN3.Provider.ORiN3NullableInt8ArrayH\x00\x12\x33\n\x05int16\x18\x1e \x01(\x0b\x32\".Message.ORiN3.Provider.ORiN3Int16H\x00\x12>\n\x0bint16_array\x18\x1f \x01(\x0b\x32\'.Message.ORiN3.Provider.ORiN3Int16ArrayH\x00\x12\x44\n\x0enullable_int16\x18  \x01(\x0b\x32*.Message.ORiN3.Provider.ORiN3NullableInt16H\x00\x12O\n\x14nullable_int16_array\x18! \x01(\x0b\x32/.Message.ORiN3.Provider.ORiN3NullableInt16ArrayH\x00\x12\x33\n\x05int32\x18( \x01(\x0b\x32\".Message.ORiN3.Provider.ORiN3Int32H\x00\x12>\n\x0bint32_array\x18) \x01(\x0b\x32\'.Message.ORiN3.Provider.ORiN3Int32ArrayH\x00\x12\x44\n\x0enullable_int32\x18* \x01(\x0b\x32*.Message.ORiN3.Provider.ORiN3NullableInt32H\x00\x12O\n\x14nullable_int32_array\x18+ \x01(\x0b\x32/.Message.ORiN3.Provider.ORiN3NullableInt32ArrayH\x00\x12\x33\n\x05int64\x18\x32 \x01(\x0b\x32\".Message.ORiN3.Provider.ORiN3Int64H\x00\x12>\n\x0bint64_array\x18\x33 \x01(\x0b\x32\'.Message.ORiN3.Provider.ORiN3Int64ArrayH\x00\x12\x44\n\x0enullable_int64\x18\x34 \x01(\x0b\x32*.Message.ORiN3.Provider.ORiN3NullableInt64H\x00\x12O\n\x14nullable_int64_array\x18\x35 \x01(\x0b\x32/.Message.ORiN3.Provider.ORiN3NullableInt64ArrayH\x00\x12\x33\n\x05uint8\x18< \x01(\x0b\x32\".Message.ORiN3.Provider.ORiN3UInt8H\x00\x12>\n\x0buint8_array\x18= \x01(\x0b\x32\'.Message.ORiN3.Provider.ORiN3UInt8ArrayH\x00\x12\x44\n\x0enullable_uint8\x18> \x01(\x0b\x32*.Message.ORiN3.Provider.ORiN3NullableUInt8H\x00\x12O\n\x14nullable_uint8_array\x18? \x01(\x0b\x32/.Message.ORiN3.Provider.ORiN3NullableUInt8ArrayH\x00\x12\x35\n\x06uint16\x18\x46 \x01(\x0b\x32#.Message.ORiN3.Provider.ORiN3UInt16H\x00\x12@\n\x0cuint16_array\x18G \x01(\x0b\x32(.Message.ORiN3.Provider.ORiN3UInt16ArrayH\x00\x12\x46\n\x0fnullable_uint16\x18H \x01(\x0b\x32+.Message.ORiN3.Provider.ORiN3NullableUInt16H\x00\x12Q\n\x15nullable_uint16_array\x18I \x01(\x0b\x32\x30.Message.ORiN3.Provider.ORiN3NullableUInt16ArrayH\x00\x12\x35\n\x06uint32\x18P \x01(\x0b\x32#.Message.ORiN3.Provider.ORiN3UInt32H\x00\x12@\n\x0cuint32_array\x18Q \x01(\x0b\x32(.Message.ORiN3.Provider.ORiN3UInt32ArrayH\x00\x12\x46\n\x0fnullable_uint32\x18R \x01(\x0b\x32+.Message.ORiN3.Provider.ORiN3NullableUInt32H\x00\x12Q\n\x15nullable_uint32_array\x18S \x01(\x0b\x32\x30.Message.ORiN3.Provider.ORiN3NullableUInt32ArrayH\x00\x12\x35\n\x06uint64\x18Z \x01(\x0b\x32#.Message.ORiN3.Provider.ORiN3UInt64H\x00\x12@\n\x0cuint64_array\x18[ \x01(\x0b\x32(.Message.ORiN3.Provider.ORiN3UInt64ArrayH\x00\x12\x46\n\x0fnullable_uint64\x18\\ \x01(\x0b\x32+.Message.ORiN3.Provider.ORiN3NullableUInt64H\x00\x12Q\n\x15nullable_uint64_array\x18] \x01(\x0b\x32\x30.Message.ORiN3.Provider.ORiN3NullableUInt64ArrayH\x00\x12\x33\n\x05\x66loat\x18\x64 \x01(\x0b\x32\".Message.ORiN3.Provider.ORiN3FloatH\x00\x12>\n\x0b\x66loat_array\x18\x65 \x01(\x0b\x32\'.Message.ORiN3.Provider.ORiN3FloatArrayH\x00\x12\x44\n\x0enullable_float\x18\x66 \x01(\x0b\x32*.Message.ORiN3.Provider.ORiN3NullableFloatH\x00\x12O\n\x14nullable_float_array\x18g \x01(\x0b\x32/.Message.ORiN3.Provider.ORiN3NullableFloatArrayH\x00\x12\x35\n\x06\x64ouble\x18n \x01(\x0b\x32#.Message.ORiN3.Provider.ORiN3DoubleH\x00\x12@\n\x0c\x64ouble_array\x18o \x01(\x0b\x32(.Message.ORiN3.Provider.ORiN3DoubleArrayH\x00\x12\x46\n\x0fnullable_double\x18p \x01(\x0b\x32+.Message.ORiN3.Provider.ORiN3NullableDoubleH\x00\x12Q\n\x15nullable_double_array\x18q \x01(\x0b\x32\x30.Message.ORiN3.Provider.ORiN3NullableDoubleArrayH\x00\x12\x35\n\x06string\x18x \x01(\x0b\x32#.Message.ORiN3.Provider.ORiN3StringH\x00\x12@\n\x0cstring_array\x18y \x01(\x0b\x32(.Message.ORiN3.Provider.ORiN3StringArrayH\x00\x12:\n\x08\x64\x61tetime\x18\x82\x01 \x01(\x0b\x32%.Message.ORiN3.Provider.ORiN3DateTimeH\x00\x12\x45\n\x0e\x64\x61tetime_array\x18\x83\x01 \x01(\x0b\x32*.Message.ORiN3.Provider.ORiN3DateTimeArrayH\x00\x12K\n\x11nullable_datetime\x18\x84\x01 \x01(\x0b\x32-.Message.ORiN3.Provider.ORiN3NullableDateTimeH\x00\x12V\n\x17nullable_datetime_array\x18\x85\x01 \x01(\x0b\x32\x32.Message.ORiN3.Provider.ORiN3NullableDateTimeArrayH\x00\x12;\n\x06object\x18\x8c\x01 \x01(\x0b\x32(.Message.ORiN3.Provider.ORiN3ValueObjectH\x00\x42\x07\n\x05value\"\x1e\n\tORiN3Bool\x12\x11\n\traw_value\x18\x01 \x01(\x08\"#\n\x0eORiN3BoolArray\x12\x11\n\traw_value\x18\x01 \x03(\x08\"7\n\x11ORiN3NullableBool\x12\x0f\n\x07is_null\x18\x01 \x01(\x08\x12\x11\n\traw_value\x18\x02 \x01(\x08\"V\n\x16ORiN3NullableBoolArray\x12<\n\traw_value\x18\x01 \x03(\x0b\x32).Message.ORiN3.Provider.ORiN3NullableBool\"\x1e\n\tORiN3Int8\x12\x11\n\traw_value\x18\x01 \x01(\x05\"#\n\x0eORiN3Int8Array\x12\x11\n\traw_value\x18\x01 \x03(\x05\"7\n\x11ORiN3NullableInt8\x12\x0f\n\x07is_null\x18\x01 \x01(\x08\x12\x11\n\traw_value\x18\x02 \x01(\x05\"V\n\x16ORiN3NullableInt8Array\x12<\n\traw_value\x18\x01 \x03(\x0b\x32).Message.ORiN3.Provider.ORiN3NullableInt8\"\x1f\n\nORiN3Int16\x12\x11\n\traw_value\x18\x01 \x01(\x05\"$\n\x0fORiN3Int16Array\x12\x11\n\traw_value\x18\x01 \x03(\x05\"8\n\x12ORiN3NullableInt16\x12\x0f\n\x07is_null\x18\x01 \x01(\x08\x12\x11\n\traw_value\x18\x02 \x01(\x05\"X\n\x17ORiN3NullableInt16Array\x12=\n\traw_value\x18\x01 \x03(\x0b\x32*.Message.ORiN3.Provider.ORiN3NullableInt16\"\x1f\n\nORiN3Int32\x12\x11\n\traw_value\x18\x01 \x01(\x05\"$\n\x0fORiN3Int32Array\x12\x11\n\traw_value\x18\x01 \x03(\x05\"8\n\x12ORiN3NullableInt32\x12\x0f\n\x07is_null\x18\x01 \x01(\x08\x12\x11\n\traw_value\x18\x02 \x01(\x05\"X\n\x17ORiN3NullableInt32Array\x12=\n\traw_value\x18\x01 \x03(\x0b\x32*.Message.ORiN3.Provider.ORiN3NullableInt32\"\x1f\n\nORiN3Int64\x12\x11\n\traw_value\x18\x01 \x01(\x03\"$\n\x0fORiN3Int64Array\x12\x11\n\traw_value\x18\x01 \x03(\x03\"8\n\x12ORiN3NullableInt64\x12\x0f\n\x07is_null\x18\x01 \x01(\x08\x12\x11\n\traw_value\x18\x02 \x01(\x03\"X\n\x17ORiN3NullableInt64Array\x12=\n\traw_value\x18\x01 \x03(\x0b\x32*.Message.ORiN3.Provider.ORiN3NullableInt64\"\x1f\n\nORiN3UInt8\x12\x11\n\traw_value\x18\x01 \x01(\r\"$\n\x0fORiN3UInt8Array\x12\x11\n\traw_value\x18\x01 \x03(\r\"8\n\x12ORiN3NullableUInt8\x12\x0f\n\x07is_null\x18\x01 \x01(\x08\x12\x11\n\traw_value\x18\x02 \x01(\r\"X\n\x17ORiN3NullableUInt8Array\x12=\n\traw_value\x18\x01 \x03(\x0b\x32*.Message.ORiN3.Provider.ORiN3NullableUInt8\" \n\x0bORiN3UInt16\x12\x11\n\traw_value\x18\x01 \x01(\r\"%\n\x10ORiN3UInt16Array\x12\x11\n\traw_value\x18\x01 \x03(\r\"9\n\x13ORiN3NullableUInt16\x12\x0f\n\x07is_null\x18\x01 \x01(\x08\x12\x11\n\traw_value\x18\x02 \x01(\r\"Z\n\x18ORiN3NullableUInt16Array\x12>\n\traw_value\x18\x01 \x03(\x0b\x32+.Message.ORiN3.Provider.ORiN3NullableUInt16\" \n\x0bORiN3UInt32\x12\x11\n\traw_value\x18\x01 \x01(\r\"%\n\x10ORiN3UInt32Array\x12\x11\n\traw_value\x18\x01 \x03(\r\"9\n\x13ORiN3NullableUInt32\x12\x0f\n\x07is_null\x18\x01 \x01(\x08\x12\x11\n\traw_value\x18\x02 \x01(\r\"Z\n\x18ORiN3NullableUInt32Array\x12>\n\traw_value\x18\x01 \x03(\x0b\x32+.Message.ORiN3.Provider.ORiN3NullableUInt32\" \n\x0bORiN3UInt64\x12\x11\n\traw_value\x18\x01 \x01(\x04\"%\n\x10ORiN3UInt64Array\x12\x11\n\traw_value\x18\x01 \x03(\x04\"9\n\x13ORiN3NullableUInt64\x12\x0f\n\x07is_null\x18\x01 \x01(\x08\x12\x11\n\traw_value\x18\x02 \x01(\x04\"Z\n\x18ORiN3NullableUInt64Array\x12>\n\traw_value\x18\x01 \x03(\x0b\x32+.Message.ORiN3.Provider.ORiN3NullableUInt64\"\x1f\n\nORiN3Float\x12\x11\n\traw_value\x18\x01 \x01(\x02\"$\n\x0fORiN3FloatArray\x12\x11\n\traw_value\x18\x01 \x03(\x02\"8\n\x12ORiN3NullableFloat\x12\x0f\n\x07is_null\x18\x01 \x01(\x08\x12\x11\n\traw_value\x18\x02 \x01(\x02\"X\n\x17ORiN3NullableFloatArray\x12=\n\traw_value\x18\x01 \x03(\x0b\x32*.Message.ORiN3.Provider.ORiN3NullableFloat\" \n\x0bORiN3Double\x12\x11\n\traw_value\x18\x01 \x01(\x01\"%\n\x10ORiN3DoubleArray\x12\x11\n\traw_value\x18\x01 \x03(\x01\"9\n\x13ORiN3NullableDouble\x12\x0f\n\x07is_null\x18\x01 \x01(\x08\x12\x11\n\traw_value\x18\x02 \x01(\x01\"Z\n\x18ORiN3NullableDoubleArray\x12>\n\traw_value\x18\x01 \x03(\x0b\x32+.Message.ORiN3.Provider.ORiN3NullableDouble\"1\n\x0bORiN3String\x12\x0f\n\x07is_null\x18\x01 \x01(\x08\x12\x11\n\traw_value\x18\x02 \x01(\t\"J\n\x10ORiN3StringArray\x12\x36\n\traw_value\x18\x01 \x03(\x0b\x32#.Message.ORiN3.Provider.ORiN3String\"\"\n\rORiN3DateTime\x12\x11\n\traw_value\x18\x01 \x01(\x03\"\'\n\x12ORiN3DateTimeArray\x12\x11\n\traw_value\x18\x01 \x03(\x03\";\n\x15ORiN3NullableDateTime\x12\x0f\n\x07is_null\x18\x01 \x01(\x08\x12\x11\n\traw_value\x18\x02 \x01(\x03\"^\n\x1aORiN3NullableDateTimeArray\x12@\n\traw_value\x18\x01 \x03(\x0b\x32-.Message.ORiN3.Provider.ORiN3NullableDateTime\"%\n\x10ORiN3ValueObject\x12\x11\n\traw_value\x18\x01 \x01(\x0c\x42X\xaa\x02\'Message.ORiN3.Provider.V1.AutoGenerated\xea\x02+Message::ORiN3::Provider::V1::AutoGeneratedb\x06proto3"

pool = Google::Protobuf::DescriptorPool.generated_pool
pool.add_serialized_file(descriptor_data)

module Message
  module ORiN3
    module Provider
      module V1
        module AutoGenerated
          CommonRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.CommonRequest").msgclass
          CommonResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.CommonResponse").msgclass
          ORiN3Value = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3Value").msgclass
          ORiN3Bool = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3Bool").msgclass
          ORiN3BoolArray = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3BoolArray").msgclass
          ORiN3NullableBool = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3NullableBool").msgclass
          ORiN3NullableBoolArray = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3NullableBoolArray").msgclass
          ORiN3Int8 = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3Int8").msgclass
          ORiN3Int8Array = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3Int8Array").msgclass
          ORiN3NullableInt8 = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3NullableInt8").msgclass
          ORiN3NullableInt8Array = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3NullableInt8Array").msgclass
          ORiN3Int16 = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3Int16").msgclass
          ORiN3Int16Array = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3Int16Array").msgclass
          ORiN3NullableInt16 = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3NullableInt16").msgclass
          ORiN3NullableInt16Array = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3NullableInt16Array").msgclass
          ORiN3Int32 = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3Int32").msgclass
          ORiN3Int32Array = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3Int32Array").msgclass
          ORiN3NullableInt32 = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3NullableInt32").msgclass
          ORiN3NullableInt32Array = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3NullableInt32Array").msgclass
          ORiN3Int64 = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3Int64").msgclass
          ORiN3Int64Array = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3Int64Array").msgclass
          ORiN3NullableInt64 = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3NullableInt64").msgclass
          ORiN3NullableInt64Array = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3NullableInt64Array").msgclass
          ORiN3UInt8 = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3UInt8").msgclass
          ORiN3UInt8Array = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3UInt8Array").msgclass
          ORiN3NullableUInt8 = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3NullableUInt8").msgclass
          ORiN3NullableUInt8Array = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3NullableUInt8Array").msgclass
          ORiN3UInt16 = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3UInt16").msgclass
          ORiN3UInt16Array = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3UInt16Array").msgclass
          ORiN3NullableUInt16 = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3NullableUInt16").msgclass
          ORiN3NullableUInt16Array = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3NullableUInt16Array").msgclass
          ORiN3UInt32 = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3UInt32").msgclass
          ORiN3UInt32Array = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3UInt32Array").msgclass
          ORiN3NullableUInt32 = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3NullableUInt32").msgclass
          ORiN3NullableUInt32Array = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3NullableUInt32Array").msgclass
          ORiN3UInt64 = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3UInt64").msgclass
          ORiN3UInt64Array = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3UInt64Array").msgclass
          ORiN3NullableUInt64 = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3NullableUInt64").msgclass
          ORiN3NullableUInt64Array = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3NullableUInt64Array").msgclass
          ORiN3Float = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3Float").msgclass
          ORiN3FloatArray = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3FloatArray").msgclass
          ORiN3NullableFloat = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3NullableFloat").msgclass
          ORiN3NullableFloatArray = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3NullableFloatArray").msgclass
          ORiN3Double = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3Double").msgclass
          ORiN3DoubleArray = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3DoubleArray").msgclass
          ORiN3NullableDouble = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3NullableDouble").msgclass
          ORiN3NullableDoubleArray = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3NullableDoubleArray").msgclass
          ORiN3String = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3String").msgclass
          ORiN3StringArray = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3StringArray").msgclass
          ORiN3DateTime = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3DateTime").msgclass
          ORiN3DateTimeArray = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3DateTimeArray").msgclass
          ORiN3NullableDateTime = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3NullableDateTime").msgclass
          ORiN3NullableDateTimeArray = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3NullableDateTimeArray").msgclass
          ORiN3ValueObject = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("Message.ORiN3.Provider.ORiN3ValueObject").msgclass
        end
      end
    end
  end
end
