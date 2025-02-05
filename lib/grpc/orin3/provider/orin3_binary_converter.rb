class ORiN3BinaryConverter
  module DataType
    Nil = 0
    ObjectArray = 1
    Bool = 2
    BoolArray = 3
    NullableBool = 4
    NullableBoolArray = 5
    UInt8 = 6
    UInt8Array = 7
    NullableUInt8 = 8
    NullableUInt8Array = 9
    UInt16 = 10
    UInt16Array = 11
    NullableUInt16 = 12
    NullableUInt16Array = 13
    UInt32 = 14
    UInt32Array = 15
    NullableUInt32 = 16
    NullableUInt32Array = 17
    UInt64 = 18
    UInt64Array = 19
    NullableUInt64 = 20
    NullableUInt64Array = 21
    Int8 = 22
    Int8Array = 23
    NullableInt8 = 24
    NullableInt8Array = 25
    Int16 = 26
    Int16Array = 27
    NullableInt16 = 28
    NullableInt16Array = 29
    Int32 = 30
    Int32Array = 31
    NullableInt32 = 32
    NullableInt32Array = 33
    Int64 = 34
    Int64Array = 35
    NullableInt64 = 36
    NullableInt64Array = 37
    Float = 38
    FloatArray = 39
    NullableFloat = 40
    NullableFloatArray = 41
    Double = 42
    DoubleArray = 43
    NullableDouble = 44
    NullableDoubleArray = 45
    String = 46
    StringArray = 47
    DateTime = 48
    DateTimeArray = 49
    NullableDateTime = 50
    NullableDateTimeArray = 51
    Dictionary = 52

    def self.values
      constants.map { |const| const_get(const) }
    end
  end

  UINT8_MIN = 0
  UINT8_MAX = 255
  UINT16_MIN = 0
  UINT16_MAX = 65535
  UINT32_MIN = 0
  UINT32_MAX = 4_294_967_295
  UINT64_MIN = 0
  UINT64_MAX = 18_446_744_073_709_551_615
  INT8_MIN = -128
  INT8_MAX = 127
  INT16_MIN = -32768
  INT16_MAX = 32767
  INT32_MIN = -2_147_483_648
  INT32_MAX = 2_147_483_647
  INT64_MIN = -9_223_372_036_854_775_808
  INT64_MAX = 9_223_372_036_854_775_807
  FLOAT_MIN = -3.40282347E+38
  FLOAT_MAX = 3.40282347E+38
  DOUBLE_MIN = -1.7976931348623157e+308
  DOUBLE_MAX = 1.7976931348623157e+308

  def self.serialize(data, type = nil)
    if (!type.nil?)
      return self.serialize_core(data, type)
    else
      case data
      when nil
        return self.serialize_core(data, ORiN3BinaryConverter::DataType::Nil)
      when Integer
        return self.serialize_core(data, ORiN3BinaryConverter::DataType::Int64)
      when TrueClass, FalseClass
        return self.serialize_core(data, ORiN3BinaryConverter::DataType::Bool)
      when String
        return self.serialize_core(data, ORiN3BinaryConverter::DataType::String)
      when Time
        return self.serialize_core(data, ORiN3BinaryConverter::DataType::DateTime)
      when Array
        if data.all? { |item| item.is_a?(TrueClass) || item.is_a?(FalseClass) }
          return self.serialize_core(data, ORiN3BinaryConverter::DataType::BoolArray)
        elsif data.all? { |item| item.nil? || item.is_a?(TrueClass) || item.is_a?(FalseClass) }
          return self.serialize_core(data, ORiN3BinaryConverter::DataType::NullableBoolArray)
        elsif data.all? { |item| item.is_a?(Integer) }
          return self.serialize_core(data, ORiN3BinaryConverter::DataType::Int64Array)
        elsif data.all? { |item| item.nil? || item.is_a?(Integer) }
          return self.serialize_core(data, ORiN3BinaryConverter::DataType::NullableInt64Array)
        elsif data.all? { |item| item.nil? || item.is_a?(String) }
          return self.serialize_core(data, ORiN3BinaryConverter::DataType::StringArray)
        elsif data.all? { |item| item.is_a?(DateTime) }
          return self.serialize_core(data, ORiN3BinaryConverter::DataType::DateTimeArray)
        elsif data.all? { |item| item.nil? || item.is_a?(DateTime) }
          return self.serialize_core(data, ORiN3BinaryConverter::DataType::NullableDateTimeArray)
        else
          raise ArgumentError, "Unsupported data type"
        end
      when Hash
        return self.serialize_core(data, ORiN3BinaryConverter::DataType::Dictionary)
      else
        raise ArgumentError, "Unsupported data type"
      end
    end
  end

  def self.deserialize(binary_data)
    type_indicator = binary_data[0].ord

    case type_indicator
    when ORiN3BinaryConverter::DataType::Nil
      return nil
    when ORiN3BinaryConverter::DataType::Bool
      return binary_data[1].ord == 1
    when ORiN3BinaryConverter::DataType::UInt8
      return binary_data[1].unpack('C').first
    when ORiN3BinaryConverter::DataType::Int8
      return binary_data[1].unpack('c').first
    when ORiN3BinaryConverter::DataType::UInt16
      return binary_data[1..2].unpack('S').first
    when ORiN3BinaryConverter::DataType::Int16
      return binary_data[1..2].unpack('s').first
    when ORiN3BinaryConverter::DataType::UInt32
      return binary_data[1..4].unpack('L').first
    when ORiN3BinaryConverter::DataType::Int32
      return binary_data[1..4].unpack('l').first
    when ORiN3BinaryConverter::DataType::UInt64
      return binary_data[1..8].unpack('Q').first
    when ORiN3BinaryConverter::DataType::Int64
      return binary_data[1..8].unpack('q').first
    when ORiN3BinaryConverter::DataType::Float
      return binary_data[1..4].unpack('e').first
    when ORiN3BinaryConverter::DataType::Double
      return binary_data[1..8].unpack('E').first
    when ORiN3BinaryConverter::DataType::String
      length = binary_data[1..4].unpack('L').first
      string_data = binary_data[5, length].force_encoding('UTF-8')
      return string_data
    when ORiN3BinaryConverter::DataType::DateTime
      timestamp = binary_data[1..8].unpack('q<').first
      return Grpc::ORiN3::Provider::DateTimeConverter::from_int64(timestamp)
    when ORiN3BinaryConverter::DataType::BoolArray
      length = binary_data[1..4].unpack('L').first
      result = Array.new(length, nil)
      length.times do |i|
        result[i] = binary_data[5 + i].ord == 1
      end
      return result
    when ORiN3BinaryConverter::DataType::UInt8Array
      length = binary_data[1..4].unpack('L').first
      result = Array.new(length, nil)
      length.times do |i|
        result[i] = binary_data[5 + i].unpack('C').first
      end
      return result
    when ORiN3BinaryConverter::DataType::Int8Array
      length = binary_data[1..4].unpack('L').first
      result = Array.new(length, nil)
      length.times do |i|
        result[i] = binary_data[5 + i].unpack('c').first
      end
      return result
    when ORiN3BinaryConverter::DataType::UInt16Array
      length = binary_data[1..4].unpack('L').first
      result = Array.new(length, nil)
      length.times do |i|
        result[i] = binary_data[5 + i * 2, 2].unpack('S<').first
      end
      return result
    when ORiN3BinaryConverter::DataType::Int16Array
      length = binary_data[1..4].unpack('L').first
      result = Array.new(length, nil)
      length.times do |i|
        result[i] = binary_data[5 + i * 2, 2].unpack('s<').first
      end
      return result
    when ORiN3BinaryConverter::DataType::UInt32Array
      length = binary_data[1..4].unpack('L').first
      result = Array.new(length, nil)
      length.times do |i|
        result[i] = binary_data[5 + i * 4, 4].unpack('L<').first
      end
      return result
    when ORiN3BinaryConverter::DataType::Int32Array
      length = binary_data[1..4].unpack('L').first
      result = Array.new(length, nil)
      length.times do |i|
        result[i] = binary_data[5 + i * 4, 4].unpack('l<').first
      end
      return result
    when ORiN3BinaryConverter::DataType::UInt64Array
      length = binary_data[1..4].unpack('L').first
      result = Array.new(length, nil)
      length.times do |i|
        result[i] = binary_data[5 + i * 8, 8].unpack('Q<').first
      end
      return result
    when ORiN3BinaryConverter::DataType::Int64Array
      length = binary_data[1..4].unpack('L').first
      result = Array.new(length, nil)
      length.times do |i|
        result[i] = binary_data[5 + i * 8, 8].unpack('q<').first
      end
      return result
    when ORiN3BinaryConverter::DataType::FloatArray
      length = binary_data[1..4].unpack('L').first
      result = Array.new(length, nil)
      length.times do |i|
        result[i] = binary_data[5 + i * 4, 4].unpack('e').first
      end
      return result
    when ORiN3BinaryConverter::DataType::DoubleArray
      length = binary_data[1..4].unpack('L').first
      result = Array.new(length, nil)
      length.times do |i|
        result[i] = binary_data[5 + i * 8, 8].unpack('E').first
      end
      return result
    when ORiN3BinaryConverter::DataType::StringArray
      length = binary_data[1..4].unpack('L').first
      result = Array.new(length, nil)
      index = 5
      length.times do |i|
        if binary_data[index]
          string_length = binary_data[index + 1, 4].unpack('L').first
          result[i] = binary_data[index + 5, string_length].force_encoding('UTF-8')
          index += string_length + 5
        else
          result[i] = nil
          index += 5
        end
      end
      return result
    when ORiN3BinaryConverter::DataType::DateTimeArray
      length = binary_data[1..4].unpack('L').first
      result = Array.new(length, nil)
      length.times do |i|
        timestamp = binary_data[5 + i * 8, 8].unpack('q<').first
        result[i] = Grpc::ORiN3::Provider::DateTimeConverter::from_int64(timestamp)
      end
      return result
    when ORiN3BinaryConverter::DataType::NullableBoolArray
      length = binary_data[1..4].unpack('L').first
      result = Array.new(length, nil)
      length.times do |i|
        index = 5 + i
        if (binary_data[index].ord == 2)
          result[i] = nil
        else
          result[i] = binary_data[index].ord == 1
        end
      end
      return result
    when ORiN3BinaryConverter::DataType::NullableUInt8Array
      length = binary_data[1..4].unpack('L').first
      result = Array.new(length, nil)
      length.times do |i|
        index = 5 + (i * 2)
        if (binary_data[index].ord == 1)
          result[i] = binary_data[index + 1].unpack('C').first
        end
      end
      return result
    when ORiN3BinaryConverter::DataType::NullableInt8Array
      length = binary_data[1..4].unpack('L<').first
      result = Array.new(length, nil)
      length.times do |i|
        index = 5 + (i * 2)
        if binary_data[index].ord == 1
          result[i] = binary_data[index + 1].unpack('c').first
        end
      end
      return result
    when ORiN3BinaryConverter::DataType::NullableUInt16Array
      length = binary_data[1..4].unpack('L<').first
      result = Array.new(length, nil)
      length.times do |i|
        index = 5 + (i * 3)
        if binary_data[index].ord == 1
          result[i] = binary_data[index + 1, 2].unpack('S<').first
        end
      end
      return result
    when ORiN3BinaryConverter::DataType::NullableInt16Array
      length = binary_data[1..4].unpack('L<').first
      result = Array.new(length, nil)
      length.times do |i|
        index = 5 + (i * 3)
        if binary_data[index].ord == 1
          result[i] = binary_data[index + 1, 2].unpack('s<').first
        end
      end
      return result
    when ORiN3BinaryConverter::DataType::NullableUInt32Array
      length = binary_data[1..4].unpack('L<').first
      result = Array.new(length, nil)
      length.times do |i|
        index = 5 + (i * 5)
        if binary_data[index].ord == 1
          result[i] = binary_data[index + 1, 4].unpack('L<').first
        end
      end
      return result
    when ORiN3BinaryConverter::DataType::NullableInt32Array
      length = binary_data[1..4].unpack('L<').first
      result = Array.new(length, nil)
      length.times do |i|
        index = 5 + (i * 5)
        if binary_data[index].ord == 1
          result[i] = binary_data[index + 1, 4].unpack('l<').first
        end
      end
      return result
    when ORiN3BinaryConverter::DataType::NullableUInt64Array
      length = binary_data[1..4].unpack('L<').first
      result = Array.new(length, nil)
      length.times do |i|
        index = 5 + (i * 9)
        if binary_data[index].ord == 1
          result[i] = binary_data[index + 1, 8].unpack('Q<').first
        end
      end
      return result
    when ORiN3BinaryConverter::DataType::NullableInt64Array
      length = binary_data[1..4].unpack('L<').first
      result = Array.new(length, nil)
      length.times do |i|
        index = 5 + (i * 9)
        if binary_data[index].ord == 1
          result[i] = binary_data[index + 1, 8].unpack('q<').first
        end
      end
      return result
    when ORiN3BinaryConverter::DataType::NullableFloatArray
      length = binary_data[1..4].unpack('L<').first
      result = Array.new(length, nil)
      length.times do |i|
        index = 5 + (i * 5)
        if binary_data[index].ord == 1
          result[i] = binary_data[index + 1, 4].unpack('e').first
        end
      end
      return result
    when ORiN3BinaryConverter::DataType::NullableDoubleArray
      length = binary_data[1..4].unpack('L<').first
      result = Array.new(length, nil)
      length.times do |i|
        index = 5 + (i * 9)
        if binary_data[index].ord == 1
          result[i] = binary_data[index + 1, 8].unpack('E').first
        end
      end
      return result
    when ORiN3BinaryConverter::DataType::NullableDateTimeArray
      length = binary_data[1..4].unpack('L').first
      result = Array.new(length, nil)
      length.times do |i|
        index = 5 + (i * 9)
        if binary_data[index].ord == 1
          timestamp = binary_data[index + 1, 8].unpack('q<').first
          result[i] = Grpc::ORiN3::Provider::DateTimeConverter::from_int64(timestamp)
        end
      end
      return result
    else
      raise ArgumentError, "Unsupported data type: #{type_indicator}. Binary data: #{binary_data.inspect}"
    end
  end

  def self.from_dictionary_to_binary(data)
    length_data = data.map do |key, value|
      5 + key.bytes.length + value.length
    end
    length = length_data.sum
    byte_array = Array.new(length + 4, 0)
    byte_array[0..3] = [data.keys.length].pack('l<').bytes
    index = 4
    data.each do |key, value|
      string_bytes = key.bytes
      byte_array[index] = ORiN3BinaryConverter::DataType::String
      byte_array[(index + 1)..(index + 4)] = [string_bytes.length].pack('L').bytes
      
      # キーのバイト配列を追加
      byte_array[(index + 5)..(index + 5 + string_bytes.length - 1)] = string_bytes
      
      index += 5 + string_bytes.length
      # 値がバイナリデータの場合、バイト配列として追加する
      if value.is_a?(String)
        byte_array[index..(index + value.bytes.length - 1)] = value.bytes
        index += value.bytes.length
      else
        raise ArgumentError, "Value is not a valid binary string."
      end
    end
    return byte_array.pack('C*')
  end

  private
  def self.serialize_core(data, type)
    case type
    when ORiN3BinaryConverter::DataType::Nil
      byte_array = Array.new(1, 0)
      byte_array[0] = ORiN3BinaryConverter::DataType::Nil
      return byte_array.pack('C*')

    when ORiN3BinaryConverter::DataType::Bool
      serialize_not_null_not_array_no_range([ TrueClass, FalseClass ], data, type, 1) { data ? 1 : 0 }
    when ORiN3BinaryConverter::DataType::UInt8
      serialize_not_null_not_array([ Integer ], data, type, 1, UINT8_MIN, UINT8_MAX, "UInt8") { data }
    when ORiN3BinaryConverter::DataType::UInt16
      serialize_not_null_not_array([ Integer ], data, type, 2, UINT16_MIN, UINT16_MAX, "UInt16") { [data].pack('S<').bytes }
    when ORiN3BinaryConverter::DataType::UInt32
      serialize_not_null_not_array([ Integer ], data, type, 4, UINT32_MIN, UINT32_MAX, "UInt32") { [data].pack('L<').bytes }
    when ORiN3BinaryConverter::DataType::UInt64
      serialize_not_null_not_array([ Integer ], data, type, 8, UINT64_MIN, UINT64_MAX, "UInt64") { [data].pack('Q<').bytes }
    when ORiN3BinaryConverter::DataType::Int8
      serialize_not_null_not_array([ Integer ], data, type, 1, INT8_MIN, INT8_MAX, "Int8") { data }
    when ORiN3BinaryConverter::DataType::Int16
      serialize_not_null_not_array([ Integer ], data, type, 2, INT16_MIN, INT16_MAX, "Int16") { [data].pack('s<').bytes }
    when ORiN3BinaryConverter::DataType::Int32
      serialize_not_null_not_array([ Integer ], data, type, 4, INT32_MIN, INT32_MAX, "Int32") { [data].pack('l<').bytes }
    when ORiN3BinaryConverter::DataType::Int64
      serialize_not_null_not_array([ Integer ], data, type, 8, INT64_MIN, INT64_MAX, "Int64") { [data].pack('q<').bytes }
    when ORiN3BinaryConverter::DataType::Float
      serialize_not_null_not_array_no_range([ Float ], data, type, 4) { [data].pack('e').bytes }
    when ORiN3BinaryConverter::DataType::Double
      serialize_not_null_not_array_no_range([ Float ], data, type, 8) { [data].pack('E').bytes }
    when ORiN3BinaryConverter::DataType::DateTime
      serialize_not_null_not_array_no_range([ Time ], data, type, 8) { [Grpc::ORiN3::Provider::DateTimeConverter.to_int64(data)].pack('q<').bytes }
    when ORiN3BinaryConverter::DataType::String
      if !data.nil? && !data.is_a?(String)
        raise ArgumentError, "Value is not #{String}."
      end
      string_bytes = data.bytes
      length = string_bytes.length
      byte_array = Array.new(1 + 4 + length, 0)
      byte_array[0] = ORiN3BinaryConverter::DataType::String
      byte_array[1..4] = [length].pack('L').bytes
      byte_array[5..] = string_bytes
      return byte_array.pack('C*')

    when ORiN3BinaryConverter::DataType::BoolArray
      serialize_not_null_array_no_range([ TrueClass, FalseClass ], data, type, 1) { |item| item ? 1 : 0 }
    when ORiN3BinaryConverter::DataType::UInt8Array
      serialize_not_null_array([ Integer ], data, type, 1, UINT8_MIN, UINT8_MAX, "UInt8") { |item| item }
    when ORiN3BinaryConverter::DataType::UInt16Array
      serialize_not_null_array([ Integer ], data, type, 2, UINT16_MIN, UINT16_MAX, "UInt16") { |item| [item].pack('S<').bytes }
    when ORiN3BinaryConverter::DataType::UInt32Array
      serialize_not_null_array([ Integer ], data, type, 4, UINT32_MIN, UINT32_MAX, "UInt32") { |item| [item].pack('L<').bytes }
    when ORiN3BinaryConverter::DataType::UInt64Array
      serialize_not_null_array([ Integer ], data, type, 8, UINT64_MIN, UINT64_MAX, "UInt64") { |item| [item].pack('Q<').bytes }
    when ORiN3BinaryConverter::DataType::Int8Array
      serialize_not_null_array([ Integer ], data, type, 1, INT8_MIN, INT8_MAX, "Int8") { |item| item }
    when ORiN3BinaryConverter::DataType::Int16Array
      serialize_not_null_array([ Integer ], data, type, 2, INT16_MIN, INT16_MAX, "Int16") { |item| [item].pack('s<').bytes }
    when ORiN3BinaryConverter::DataType::Int32Array
      serialize_not_null_array([ Integer ], data, type, 4, INT32_MIN, INT32_MAX, "Int32") { |item| [item].pack('l<').bytes }
    when ORiN3BinaryConverter::DataType::Int64Array
      serialize_not_null_array([ Integer ], data, type, 8, INT64_MIN, INT64_MAX, "Int64") { |item| [item].pack('q<').bytes }
    when ORiN3BinaryConverter::DataType::FloatArray
      serialize_not_null_array_no_range([ Float ], data, type, 4) { |item| [item].pack('e').bytes }
    when ORiN3BinaryConverter::DataType::DoubleArray
      serialize_not_null_array_no_range([ Float ], data, type, 8) { |item| [item].pack('E').bytes }
    when ORiN3BinaryConverter::DataType::DateTimeArray
      serialize_not_null_array_no_range([ Time ], data, type, 8) { |item| [Grpc::ORiN3::Provider::DateTimeConverter.to_int64(item)].pack('q<').bytes }
    when ORiN3BinaryConverter::DataType::StringArray
      if data.nil?
        raise ArgumentError, "Value is nil."
      elsif !data.is_a?(Array)
        raise ArgumentError, "Value is not Array."
      end
      data.each do |item|
        if !item.nil? && !item.is_a?(String)
          raise ArgumentError, "Value is not #{String}."
        end
      end
      total_length = data.sum { |item| item.nil? ? 0 : item.bytes.length } + data.length * 5 + 5
      byte_array = Array.new(total_length, 0)
      byte_array[0] = ORiN3BinaryConverter::DataType::StringArray
      byte_array[1..4] = [data.length].pack('L<').bytes
      offset = 5
      data.each do |item|
        if item.nil?
          offset += 5
        else
          string_bytes = item.bytes
          length = string_bytes.length
          byte_array[offset, 1] = 1
          offset += 1
          byte_array[offset, 4] = [length].pack('L<').bytes
          offset += 4
          byte_array[offset, length] = string_bytes
          offset += length
        end
      end
      return byte_array.pack('C*')

    when ORiN3BinaryConverter::DataType::NullableBoolArray
      if data.nil?
        raise ArgumentError, "Value is nil."
      elsif !data.is_a?(Array)
        raise ArgumentError, "Value is not Array."
      end
      data.each do |item|
        if !item.nil? && (!item.is_a?(TrueClass) && !item.is_a?(FalseClass))
          raise ArgumentError, "Value is not #{String}."
        end
      end
      byte_array = Array.new(1 + 4 + data.length, 0)
      byte_array[0] = ORiN3BinaryConverter::DataType::NullableBoolArray
      byte_array[1..4] = [data.length].pack('l<').bytes
      data.each_with_index do |item, index|
        if (data[index].nil?)
          byte_array[5 + index] = 2
        else
          byte_array[5 + index] = data[index] ? 1 : 0
        end
      end
      return byte_array.pack('C*')

    when ORiN3BinaryConverter::DataType::NullableUInt8Array
      serialize_array([ Integer ], data, type, 1, UINT8_MIN, UINT8_MAX, "UInt8") { |item| item }
    when ORiN3BinaryConverter::DataType::NullableUInt16Array
      serialize_array([ Integer ], data, type, 2, UINT16_MIN, UINT16_MAX, "UInt16") { |item| [item].pack('S<').bytes }
    when ORiN3BinaryConverter::DataType::NullableUInt32Array
      serialize_array([ Integer ], data, type, 4, UINT32_MIN, UINT32_MAX, "UInt32") { |item| [item].pack('L<').bytes }
    when ORiN3BinaryConverter::DataType::NullableUInt64Array
      serialize_array([ Integer ], data, type, 8, UINT64_MIN, UINT64_MAX, "UInt64") { |item| [item].pack('Q<').bytes }
    when ORiN3BinaryConverter::DataType::NullableInt8Array
      serialize_array([ Integer ], data, type, 1, INT8_MIN, INT8_MAX, "Int8") { |item| item }
    when ORiN3BinaryConverter::DataType::NullableInt16Array
      serialize_array([ Integer ], data, type, 2, INT16_MIN, INT16_MAX, "Int16") { |item| [item].pack('s<').bytes }
    when ORiN3BinaryConverter::DataType::NullableInt32Array
      serialize_array([ Integer ], data, type, 4, INT32_MIN, INT32_MAX, "Int32") { |item| [item].pack('l<').bytes }
    when ORiN3BinaryConverter::DataType::NullableInt64Array
      serialize_array([ Integer ], data, type, 8, INT64_MIN, INT64_MAX, "Int64") { |item| [item].pack('q<').bytes }
    when ORiN3BinaryConverter::DataType::NullableFloatArray
      serialize_array_no_range([ Float ], data, type, 4) { |item| [item].pack('e').bytes }
    when ORiN3BinaryConverter::DataType::NullableDoubleArray
      serialize_array_no_range([ Float ], data, type, 8) { |item| [item].pack('E').bytes }
    when ORiN3BinaryConverter::DataType::NullableDateTimeArray
      serialize_array_no_range([ Time ], data, type, 8) { |item| [Grpc::ORiN3::Provider::DateTimeConverter.to_int64(item)].pack('q<').bytes }
    # when ORiN3BinaryConverter::DataType::Dictionary
    #   if data.nil?
    #     raise ArgumentError, "Value is nil."
    #   elsif !data.is_a?(Hash)
    #     raise ArgumentError, "Value is not Hash."
    #   end
    #   # data.each do |item|
    #   #   if !item.nil? && (!item.is_a?(TrueClass) && !item.is_a?(FalseClass))
    #   #     raise ArgumentError, "Value is not #{String}."
    #   #   end
    #   # end
    #   length_data = data.map do |key, value|
    #     5 + key.bytes.length + value.length
    #   end
    #   length = length_data.sum
    #   byte_array = Array.new(length + 9, 0)
    #   byte_array[0] = ORiN3BinaryConverter::DataType::Dictionary
    #   byte_array[1..4] = [length].pack('l<').bytes
    #   byte_array[5..8] = [data.keys.length].pack('l<').bytes
    #   index = 9
    #   data.each do |key, value|
    #     string_bytes = key.bytes
    #     byte_array[index] = ORiN3BinaryConverter::DataType::String
    #     byte_array[(index + 1)..(index + 4)] = [string_bytes.length].pack('L').bytes
        
    #     # キーのバイト配列を追加
    #     byte_array[(index + 5)..(index + 5 + string_bytes.length - 1)] = string_bytes
        
    #     index += 5 + string_bytes.length
        
    #     # 値がバイナリデータの場合、バイト配列として追加する
    #     if value.is_a?(String)
    #       byte_array[index..(index + value.bytes.length - 1)] = value.bytes
    #       index += value.bytes.length
    #     else
    #       raise ArgumentError, "Value is not a valid binary string."
    #     end
    #   end
    #   puts "byte_array=#{byte_array}"
    #   return byte_array.pack('C*')
    else
      raise ArgumentError, "Unsupported data type"
    end
  end

  def self.serialize_not_null_not_array(ruby_type, data, type, data_size, min, max, type_name, &packer)
    if !data.nil? && !ruby_type.any? { |element| data.is_a?(element) }
      raise ArgumentError, "Value is not #{ruby_type}."
    elsif !data.nil? && (data < min || max < data)
      raise ArgumentError, "Value #{data} is out of range for #{type_name}. It must be between #{min} and #{max}."
    end
    serialize_not_null_not_array_no_range(ruby_type, data, type, data_size) { yield packer }
  end

  def self.serialize_not_null_not_array_no_range(ruby_type, data, type, data_size, &packer)
    if data.nil?
      raise ArgumentError, "Value is nil."
    elsif !ruby_type.any? { |element| data.is_a?(element) }
      raise ArgumentError, "Value is not #{ruby_type}."
    end
    byte_array = Array.new(data_size + 1, 0)
    byte_array[0] = type
    byte_array[1..data_size] = yield packer
    return byte_array.pack('C*')
  end

  def self.serialize_not_null_array(ruby_type, data, type, data_size, min, max, type_name, &packer)
    serialize_not_null_array_core(ruby_type, data, type, data_size, true, min, max, type_name) { |item| yield item }
  end

  def self.serialize_not_null_array_no_range(ruby_type, data, type, data_size, &packer)
    serialize_not_null_array_core(ruby_type, data, type, data_size, false, nil, nil, nil) { |item| yield item }
  end

  def self.serialize_not_null_array_core(ruby_type, data, type, data_size, range_check_flg, min, max, type_name, &packer)
    if data.nil?
      raise ArgumentError, "Value is nil."
    elsif !data.is_a?(Array)
      raise ArgumentError, "Value is not Array."
    end
    byte_array = Array.new(1 + 4 + (data_size * data.length), 0)
    byte_array[0] = type
    byte_array[1..4] = [data.length].pack('L<').bytes
    data.each_with_index do |item, index|
      if item.nil?
        raise ArgumentError, "Value is nil."
      elsif !ruby_type.any? { |element| item.is_a?(element) }
        raise ArgumentError, "Value is not #{ruby_type}."
      elsif range_check_flg && (item < min || max < item)
        raise ArgumentError, "Value #{item} is out of range for #{type_name}. It must be between #{min} and #{max}."
      end
      byte_array[5 + (data_size * index), data_size] = yield item
    end
    return byte_array.pack('C*')
  end

  def self.serialize_array(ruby_type, data, type, data_size, min, max, type_name, &packer)
    serialize_array_core(ruby_type, data, type, data_size, true, min, max, type_name) { |item| yield item }
  end

  def self.serialize_array_no_range(ruby_type, data, type, data_size, &packer)
    serialize_array_core(ruby_type, data, type, data_size, false, nil, nil, nil) { |item| yield item }
  end

  def self.serialize_array_core(ruby_type, data, type, data_size, range_check_flg, min, max, type_name, &packer)
    if data.nil?
      raise ArgumentError, "Value is nil."
    elsif !data.is_a?(Array)
      raise ArgumentError, "Value is not Array."
    end
    byte_array = Array.new(1 + 4 + ((data_size + 1) * data.length), 0)
    byte_array[0] = type
    byte_array[1..4] = [data.length].pack('l<').bytes
    data.each_with_index do |item, index|
      if !item.nil? && !ruby_type.any? { |element| item.is_a?(element) }
        raise ArgumentError, "Value is not #{ruby_type}."
      elsif range_check_flg && !item.nil? && (item < min || max < item)
        raise ArgumentError, "Value #{item} is out of range for #{type_name}. It must be between #{min} and #{max}."
      end
      if !item.nil?
        byte_array[5 + (index * (data_size + 1))] = 1
        byte_array[5 + (index * (data_size + 1)) + 1, data_size] = yield item
      end
    end
    return byte_array.pack('C*')
  end
end