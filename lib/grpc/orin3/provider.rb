require_relative "provider/version"
require_relative "provider/date_time_converter"
require_relative "provider/orin3_object_type"
require_relative "provider/orin3_value_type"
require_relative "../client/orin3/remoteengine/orin3_remote_engine"
require_relative "../client/orin3/provider/orin3_base_object"
require_relative "../client/orin3/provider/orin3_root_object"
require_relative "../client/orin3/provider/orin3_child_creator"
require_relative "../client/orin3/provider/orin3_controller"
require_relative "../client/orin3/provider/orin3_job"
require_relative "../client/orin3/provider/orin3_variable"
require_relative "../client/orin3/provider/orin3_file"
require_relative "../client/orin3/provider/orin3_module"
require_relative '../../../gen/Design.ORiN3.Common/V1/orin3_common_pb'
require_relative '../../../gen/Design.ORiN3.Common/V1/orin3_common_remote_engine_pb'
require_relative '../../../gen/Message.ORiN3.RemoteEngine/V1/orin3_remote_engine_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3_common_type_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3_base_object_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3_base_object_services_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3_child_creator_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3_child_creator_services_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3_child_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3_child_services_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3_controller_creator_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3_controller_creator_services_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3_executable_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3_executable_services_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3_file_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3_file_services_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3_job_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3_job_services_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3_parent_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3_parent_services_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3_resource_opener_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3_resource_opener_services_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3_root_object_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3_root_object_services_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3_stream_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3_stream_services_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3_variable_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3_variable_services_pb'
require_relative '../../../gen/Message.ORiN3.RemoteEngine/V1/orin3_remote_engine_pb'
require_relative '../../../gen/Message.ORiN3.RemoteEngine/V1/orin3_remote_engine_services_pb'

module TypeSwitcher
  def self.execute(type, branch)
    case type
    when ORiN3ValueType::ORiN3Bool
      branch.case_of_bool
    when ORiN3ValueType::ORiN3BoolArray
      branch.case_of_bool_array
    when ORiN3ValueType::ORiN3NullableBool
      branch.case_of_nullable_bool
    when ORiN3ValueType::ORiN3NullableBoolArray
      branch.case_of_nullable_bool_array
    when ORiN3ValueType::ORiN3Int8
      branch.case_of_int8
    when ORiN3ValueType::ORiN3Int8Array
      branch.case_of_int8_array
    when ORiN3ValueType::ORiN3NullableInt8
      branch.case_of_nullable_int8
    when ORiN3ValueType::ORiN3NullableInt8Array
      branch.case_of_nullable_int8_array
    when ORiN3ValueType::ORiN3Int16
      branch.case_of_int16
    when ORiN3ValueType::ORiN3Int16Array
      branch.case_of_int16_array
    when ORiN3ValueType::ORiN3NullableInt16
      branch.case_of_nullable_int16
    when ORiN3ValueType::ORiN3NullableInt16Array
      branch.case_of_nullable_int16_array
    when ORiN3ValueType::ORiN3Int32
      branch.case_of_int32
    when ORiN3ValueType::ORiN3Int32Array
      branch.case_of_int32_array
    when ORiN3ValueType::RiN3NullableInt32
      branch.case_of_nullable_int32
    when ORiN3ValueType::ORiN3NullableInt32Array
      branch.case_of_nullable_int32_array
    when ORiN3ValueType::ORiN3Int64
      branch.case_of_int64
    when ORiN3ValueType::ORiN3Int64Array
      branch.case_of_int64_array
    when ORiN3ValueType::ORiN3NullableInt64
      branch.case_of_nullable_int64
    when ORiN3ValueType::ORiN3NullableInt64Array
      branch.case_of_nullable_int64_array
    when ORiN3ValueType::ORiN3UInt8
      branch.case_of_uint8
    when ORiN3ValueType::ORiN3UInt8Array
      branch.case_of_uint8_array
    when ORiN3ValueType::ORiN3NullableUInt8
      branch.case_of_nullable_uint8
    when ORiN3ValueType::ORiN3NullableUInt8Array
      branch.case_of_nullable_uint8_array
    when ORiN3ValueType::ORiN3UInt16
      baanch.case_of_uint16
    when ORiN3ValueType::ORiN3UInt16Array
      branch.case_of_uint16_array
    when ORiN3ValueType::ORiN3NullableUInt16
      branch.case_of_nullable_uint16
    when ORiN3ValueType::ORiN3NullableUInt16Array
      branch.case_of_nullable_uint16_array    
    when ORiN3ValueType::ORiN3UInt32
      branch.case_of_uint32
    when ORiN3ValueType::ORiN3UInt32Array
      branch.case_of_uint32_array
    when ORiN3ValueType::ORiN3NullableUInt32
      branch.case_of_nullable_uint32
    when ORiN3ValueType::ORiN3NullableUInt32Array
      branch.case_of_nullable_uint32_array
    when ORiN3ValueType::ORiN3UInt64
      branch.case_of_uint64
    when ORiN3ValueType::ORiN3UInt64Array
      branch.case_of_uint64_array
    when ORiN3ValueType::ORiN3NullableUInt64
      branch.case_of_nullable_uint64
    when ORiN3ValueType::ORiN3NullableUInt64Array
      branch.case_of_nullable_uint64_array
    when ORiN3ValueType::ORiN3Float
      branch.case_of_float
    when ORiN3ValueType::ORiN3FloatArray
      branch.case_of_float_array
    when ORiN3ValueType::ORiN3NullableFloat
      branch.case_of_nullable_float
    when ORiN3ValueType::ORiN3NullableFloatArray
      branch.case_of_nullable_float_array
    when ORiN3ValueType::ORiN3Double
      branch.case_of_double
    when ORiN3ValueType::ORiN3DoubleArray
      baanch.case_of_double_array
    when ORiN3ValueType::ORiN3NullableDouble
      branch.case_of_nullable_double
    when ORiN3ValueType::ORiN3NullableDoubleArray
      branch.case_of_nullable_double_array
    when ORiN3ValueType::ORiN3String
      branch.case_of_string
    when ORiN3ValueType::ORiN3StringArray
      branch.case_of_string_array
    when ORiN3ValueType::ORiN3DateTime
      branch.case_of_datetime
    when ORiN3ValueType::ORiN3DateTimeArray
      branch.case_of_datetime_array
    when ORiN3ValueType::ORiN3NullableDateTime
      branch.case_of_nullable_datetime
    when ORiN3ValueType::ORiN3NullableDateTimeArray
      branch.case_of_nullable_datetime_array
    when ORiN3ValueType::ORiN3Object
      branch.case_of_object
    else
      branch.case_of_error
    end
  rescue => e
    raise TypeSwitcherException.new(type, e)
  end
end

class TypeSwitcherException < StandardError
  attr_reader :type

  def initialize(type, original_error)
    @type = type
    super("Error processing type #{type}: #{original_error.message}")
    set_backtrace(original_error.backtrace)
  end
end
