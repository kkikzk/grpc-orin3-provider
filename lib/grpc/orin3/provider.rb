require_relative "provider/version"
require_relative '../../../gen/Message.ORiN3.Common/V1/orin3common_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3baseobject_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3baseobject_services_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3child_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3child_services_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3childcreator_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3childcreator_services_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3controllercreator_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3controllercreator_services_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3executable_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3executable_services_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3file_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3file_services_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3job_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3job_services_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3parent_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3parent_services_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3resourceopener_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3resourceopener_services_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3rootobject_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3rootobject_services_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3stream_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3stream_services_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3variable_pb'
require_relative '../../../gen/Message.ORiN3.Provider/V1/orin3variable_services_pb'

module ORiN3ValueType
  ORiN3Bool = 10
  ORiN3BoolArray = 11
  ORiN3NullableBool = 12
  ORiN3NullableBoolArray = 13

  ORiN3Int8 = 20
  ORiN3Int8Array = 21
  ORiN3NullableInt8 = 22
  ORiN3NullableInt8Array = 23

  ORiN3Int16 = 30
  ORiN3Int16Array = 31
  ORiN3NullableInt16 = 32
  ORiN3NullableInt16Array = 33

  ORiN3Int32 = 40
  ORiN3Int32Array = 41
  ORiN3NullableInt32 = 42
  ORiN3NullableInt32Array = 43

  ORiN3Int64 = 50
  ORiN3Int64Array = 51
  ORiN3NullableInt64 = 52
  ORiN3NullableInt64Array = 53

  ORiN3UInt8 = 60
  ORiN3UInt8Array = 61
  ORiN3NullableUInt8 = 62
  ORiN3NullableUInt8Array = 63

  ORiN3UInt16 = 70
  ORiN3UInt16Array = 71
  ORiN3NullableUInt16 = 72
  ORiN3NullableUInt16Array = 73

  ORiN3UInt32 = 80
  ORiN3UInt32Array = 81
  ORiN3NullableUInt32 = 82
  ORiN3NullableUInt32Array = 83

  ORiN3UInt64 = 90
  ORiN3UInt64Array = 91
  ORiN3NullableUInt64 = 92
  ORiN3NullableUInt64Array = 93

  ORiN3Float = 100
  ORiN3FloatArray = 101
  ORiN3NullableFloat = 102
  ORiN3NullableFloatArray = 103

  ORiN3Double = 110
  ORiN3DoubleArray = 111
  ORiN3NullableDouble = 112
  ORiN3NullableDoubleArray = 113

  ORiN3String = 120
  ORiN3StringArray = 121

  ORiN3DateTime = 130
  ORiN3DateTimeArray = 131
  ORiN3NullableDateTime = 132
  ORiN3NullableDateTimeArray = 133

  ORiN3Object = 140
end

module ORiN3ObjectType
  ProviderRoot = 0
  Controller = 1
  Module = 2
  Variable = 3
  File = 4
  Stream = 5
  Event = 6
  Job = 7
end
