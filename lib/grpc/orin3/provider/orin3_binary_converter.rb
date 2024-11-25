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
      when Time, DateTime
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
      return Time.at(timestamp).to_datetime
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
      length.times do |i|
        string_length = binary_data[5 + i * 4, 4].unpack('L').first
        result[i] = binary_data[9 + i * 4, string_length].force_encoding('UTF-8')
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
    else
      raise ArgumentError, "Unsupported data type: #{type_indicator}. Binary data: #{binary_data.inspect}"
    end
  end

  private
  def self.serialize_core(data, type)
    case type
    when ORiN3BinaryConverter::DataType::Nil
      byte_array = Array.new(1, 0)
      byte_array[0] = ORiN3BinaryConverter::DataType::Nil
      return byte_array.pack('C*')
    when ORiN3BinaryConverter::DataType::Bool
      byte_array = Array.new(2, 0)
      byte_array[0] = ORiN3BinaryConverter::DataType::Bool
      byte_array[1] = data ? 1 : 0
      return byte_array.pack('C*')
    when ORiN3BinaryConverter::DataType::UInt8
      if data < 0 || data > 255
        raise ArgumentError, "Value #{data} is out of range for UInt8. It must be between 0 and 255."
      end
      byte_array = Array.new(2, 0)
      byte_array[0] = ORiN3BinaryConverter::DataType::UInt8
      byte_array[1] = data
      return byte_array.pack('C*')
    when ORiN3BinaryConverter::DataType::Int8
      if data < -128 || 127 < data
        raise ArgumentError, "Value #{data} is out of range for Int8. It must be between -128 and 127."
      end
      byte_array = Array.new(2, 0)
      byte_array[0] = ORiN3BinaryConverter::DataType::Int8
      byte_array[1] = data
      return byte_array.pack('C*')
    when ORiN3BinaryConverter::DataType::UInt16
      if data < 0 || data > 65535
        raise ArgumentError, "Value #{data} is out of range for UInt16. It must be between 0 and 65535."
      end
      byte_array = Array.new(3, 0)
      byte_array[0] = ORiN3BinaryConverter::DataType::UInt16
      byte_array[1..2] = [data].pack('S<').bytes
      return byte_array.pack('C*')
    when ORiN3BinaryConverter::DataType::Int16
      if data < -32768 || data > 32767
        raise ArgumentError, "Value #{data} is out of range for Int16. It must be between -32768 and 32767."
      end
      byte_array = Array.new(3, 0)
      byte_array[0] = ORiN3BinaryConverter::DataType::Int16
      byte_array[1..2] = [data].pack('s<').bytes
      return byte_array.pack('C*')
    when ORiN3BinaryConverter::DataType::UInt32
      if data < 0 || data > 4294967295
        raise ArgumentError, "Value #{data} is out of range for UInt32. It must be between 0 and 4294967295."
      end
      byte_array = Array.new(5, 0)
      byte_array[0] = ORiN3BinaryConverter::DataType::UInt32
      byte_array[1..4] = [data].pack('L<').bytes
      return byte_array.pack('C*')
    when ORiN3BinaryConverter::DataType::Int32
      if data < -2147483648 || data > 2147483647
        raise ArgumentError, "Value #{data} is out of range for Int32. It must be between -2147483648 and 2147483647."
      end
      byte_array = Array.new(5, 0)
      byte_array[0] = ORiN3BinaryConverter::DataType::Int32
      byte_array[1..4] = [data].pack('l<').bytes
      return byte_array.pack('C*')
    when ORiN3BinaryConverter::DataType::UInt64
      if data < 0 || data > 18446744073709551615
        raise ArgumentError, "Value #{data} is out of range for UInt64. It must be between 0 and 18446744073709551615."
      end
      byte_array = Array.new(9, 0)
      byte_array[0] = ORiN3BinaryConverter::DataType::UInt64
      byte_array[1..8] = [data].pack('Q<').bytes
      return byte_array.pack('C*')
    when ORiN3BinaryConverter::DataType::Int64
      if data < -9223372036854775808 || data > 9223372036854775807
        raise ArgumentError, "Value #{data} is out of range for Int64. It must be between -9223372036854775808 and 9223372036854775807."
      end
      byte_array = Array.new(9, 0)
      byte_array[0] = ORiN3BinaryConverter::DataType::Int64
      byte_array[1..8] = [data].pack('q<').bytes
      return byte_array.pack('C*')
    when ORiN3BinaryConverter::DataType::Float
      byte_array = Array.new(5, 0)
      byte_array[0] = ORiN3BinaryConverter::DataType::Float
      byte_array[1..4] = [data].pack('e').bytes
      return byte_array.pack('C*')
    when ORiN3BinaryConverter::DataType::Double
      byte_array = Array.new(9, 0)
      byte_array[0] = ORiN3BinaryConverter::DataType::Double
      byte_array[1..8] = [data].pack('E').bytes
      return byte_array.pack('C*')
    when ORiN3BinaryConverter::DataType::String
      string_bytes = data.bytes
      length = string_bytes.length
      byte_array = Array.new(1 + 4 + length, 0)
      byte_array[0] = ORiN3BinaryConverter::DataType::String
      byte_array[1..4] = [length].pack('L').bytes
      byte_array[5..] = string_bytes
      return byte_array.pack('C*')
    when ORiN3BinaryConverter::DataType::DateTime
      ticks = Grpc::ORiN3::Provider::DateTimeConverter.to_int64(data)
      byte_array = Array.new(9, 0)
      byte_array[0] = ORiN3BinaryConverter::DataType::DateTime
      byte_array[1..8] = [ticks].pack('q<').bytes
      return byte_array.pack('C*')
    when ORiN3BinaryConverter::DataType::BoolArray
      byte_array = Array.new(1 + 4 + data.length, 0)
      byte_array[0] = ORiN3BinaryConverter::DataType::BoolArray
      byte_array[1..4] = [data.length].pack('l<').bytes
      data.each_with_index do |item, index|
        byte_array[5 + index] = data[index] ? 1 : 0
      end
      return byte_array.pack('C*')
    when ORiN3BinaryConverter::DataType::UInt8Array
      byte_array = Array.new(1 + 4 + data.length, 0)
      byte_array[0] = ORiN3BinaryConverter::DataType::UInt8Array
      byte_array[1..4] = [data.length].pack('L<').bytes
      data.each_with_index do |item, index|
        if (!item.nil? && (item < 0 || item > 255))
          raise ArgumentError, "Value #{item} is out of range for UInt8. It must be between 0 and 255."
        end
        byte_array[5 + index] = item
      end
      return byte_array.pack('C*')
    when ORiN3BinaryConverter::DataType::Int8Array
      byte_array = Array.new(1 + 4 + data.length, 0)
      byte_array[0] = ORiN3BinaryConverter::DataType::Int8Array
      byte_array[1..4] = [data.length].pack('L<').bytes
      data.each_with_index do |item, index|
        if item < -128 || 127 < item
          raise ArgumentError, "Value #{item} is out of range for Int8. It must be between -128 and 127."
        end
        byte_array[5 + index] = item
      end
      return byte_array.pack('C*')
    when ORiN3BinaryConverter::DataType::UInt16Array
      byte_array = Array.new(1 + 4 + data.length * 2, 0)
      byte_array[0] = ORiN3BinaryConverter::DataType::UInt16Array
      byte_array[1..4] = [data.length].pack('L<').bytes
      data.each_with_index do |item, index|
        if item < 0 || item > 65535
          raise ArgumentError, "Value #{item} is out of range for UInt16. It must be between 0 and 65535."
        end
        byte_array[5 + index * 2, 2] = [item].pack('S<').bytes
      end
      return byte_array.pack('C*')
    when ORiN3BinaryConverter::DataType::Int16Array
      byte_array = Array.new(1 + 4 + data.length * 2, 0)
      byte_array[0] = ORiN3BinaryConverter::DataType::Int16Array
      byte_array[1..4] = [data.length].pack('L<').bytes
      data.each_with_index do |item, index|
        if item < -32768 || item > 32767
          raise ArgumentError, "Value #{item} is out of range for Int16. It must be between -32768 and 32767."
        end
        byte_array[5 + index * 2, 2] = [item].pack('s<').bytes
      end
      return byte_array.pack('C*')
    when ORiN3BinaryConverter::DataType::UInt32Array
      byte_array = Array.new(1 + 4 + data.length * 4, 0)
      byte_array[0] = ORiN3BinaryConverter::DataType::UInt32Array
      byte_array[1..4] = [data.length].pack('L<').bytes
      data.each_with_index do |item, index|
        if item < 0 || item > 4294967295
          raise ArgumentError, "Value #{item} is out of range for UInt32. It must be between 0 and 4294967295."
        end
        byte_array[5 + index * 4, 4] = [item].pack('L<').bytes
      end
      return byte_array.pack('C*')
    when ORiN3BinaryConverter::DataType::Int32Array
      byte_array = Array.new(1 + 4 + data.length * 4, 0)
      byte_array[0] = ORiN3BinaryConverter::DataType::Int32Array
      byte_array[1..4] = [data.length].pack('L<').bytes
      data.each_with_index do |item, index|
        if item < -2147483648 || item > 2147483647
          raise ArgumentError, "Value #{item} is out of range for Int32. It must be between -2147483648 and 2147483647."
        end
        byte_array[5 + index * 4, 4] = [item].pack('l<').bytes
      end
      return byte_array.pack('C*')
    when ORiN3BinaryConverter::DataType::UInt64Array
      byte_array = Array.new(1 + 4 + data.length * 8, 0)
      byte_array[0] = ORiN3BinaryConverter::DataType::UInt64Array
      byte_array[1..4] = [data.length].pack('L<').bytes
      data.each_with_index do |item, index|
        if !item.nil? && (item < 0 || item > 18_446_744_073_709_551_615)
          raise ArgumentError, "Value #{item} is out of range for UInt64. It must be between 0 and 18446744073709551615."
        end
        byte_array[5 + index * 8, 8] = [item].pack('Q<').bytes
      end
      return byte_array.pack('C*')
    when ORiN3BinaryConverter::DataType::Int64Array
      byte_array = Array.new(1 + 4 + data.length * 8, 0)
      byte_array[0] = ORiN3BinaryConverter::DataType::Int64Array
      byte_array[1..4] = [data.length].pack('L<').bytes
      data.each_with_index do |item, index|
        if item < -9223372036854775808 || item > 9223372036854775807
          raise ArgumentError, "Value #{item} is out of range for Int64. It must be between -9223372036854775808 and 9223372036854775807."
        end
        byte_array[5 + index * 8, 8] = [item].pack('q<').bytes
      end
      return byte_array.pack('C*')
    when ORiN3BinaryConverter::DataType::FloatArray
      byte_array = Array.new(1 + 4 + data.length * 4, 0)
      byte_array[0] = ORiN3BinaryConverter::DataType::FloatArray
      byte_array[1..4] = [data.length].pack('L<').bytes
      data.each_with_index do |item, index|
        byte_array[5 + index * 4, 4] = [item].pack('e').bytes
      end
      return byte_array.pack('C*')
    when ORiN3BinaryConverter::DataType::DoubleArray
      byte_array = Array.new(1 + 4 + data.length * 8, 0)
      byte_array[0] = ORiN3BinaryConverter::DataType::DoubleArray
      byte_array[1..4] = [data.length].pack('L<').bytes
      data.each_with_index do |item, index|
        byte_array[5 + index * 8, 8] = [item].pack('E').bytes
      end
      return byte_array.pack('C*')
    when ORiN3BinaryConverter::DataType::StringArray
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
      byte_array = Array.new(1 + 4 + (data.length * 2), 0)
      byte_array[0] = ORiN3BinaryConverter::DataType::NullableUInt8Array
      byte_array[1..4] = [data.length].pack('l<').bytes
      data.each_with_index do |item, index|
        if (!item.nil? && (item < 0 || item > 255))
          raise ArgumentError, "Value #{item} is out of range for UInt8. It must be between 0 and 255."
        end
        if !item.nil?
          byte_array[5 + (index * 2)] = 1
          byte_array[5 + (index * 2) + 1] = item
        end
      end
      return byte_array.pack('C*')
    when ORiN3BinaryConverter::DataType::NullableInt8Array
      byte_array = Array.new(1 + 4 + (data.length * 2), 0)
      byte_array[0] = ORiN3BinaryConverter::DataType::NullableInt8Array
      byte_array[1..4] = [data.length].pack('l<').bytes
      data.each_with_index do |item, index|
        if (!item.nil? && (item < -128 || item > 127))
          raise ArgumentError, "Value #{item} is out of range for Int8. It must be between -128 and 127."
        end
        if !item.nil?
          byte_array[5 + (index * 2)] = 1
          byte_array[5 + (index * 2) + 1] = item & 0xFF
        end
      end
      return byte_array.pack('C*')
    when ORiN3BinaryConverter::DataType::NullableUInt16Array
      byte_array = Array.new(1 + 4 + (data.length * 3), 0)
      byte_array[0] = ORiN3BinaryConverter::DataType::NullableUInt16Array
      byte_array[1..4] = [data.length].pack('l<').bytes
      data.each_with_index do |item, index|
        if !item.nil? && (item < 0 || item > 65_535)
          raise ArgumentError, "Value #{item} is out of range for UInt16. It must be between 0 and 65535."
        end
        if !item.nil?
          byte_array[5 + (index * 3)] = 1
          byte_array[5 + (index * 3) + 1, 2] = [item].pack('S<').bytes
        end
      end
      return byte_array.pack('C*')
    when ORiN3BinaryConverter::DataType::NullableInt16Array
      byte_array = Array.new(1 + 4 + (data.length * 3), 0)
      byte_array[0] = ORiN3BinaryConverter::DataType::NullableInt16Array
      byte_array[1..4] = [data.length].pack('l<').bytes
      data.each_with_index do |item, index|
        if !item.nil? && (item < -32_768 || item > 32_767)
          raise ArgumentError, "Value #{item} is out of range for Int16. It must be between -32768 and 32767."
        end
        if !item.nil?
          byte_array[5 + (index * 3)] = 1
          byte_array[5 + (index * 3) + 1, 2] = [item].pack('s<').bytes
        end
      end
      return byte_array.pack('C*')
    when ORiN3BinaryConverter::DataType::NullableUInt32Array
      byte_array = Array.new(1 + 4 + (data.length * 5), 0)
      byte_array[0] = ORiN3BinaryConverter::DataType::NullableUInt32Array
      byte_array[1..4] = [data.length].pack('l<').bytes
      data.each_with_index do |item, index|
        if !item.nil? && (item < 0 || item > 4_294_967_295)
          raise ArgumentError, "Value #{item} is out of range for UInt32. It must be between 0 and 4294967295."
        end
        if !item.nil?
          byte_array[5 + (index * 5)] = 1
          byte_array[5 + (index * 5) + 1, 4] = [item].pack('L<').bytes
        end
      end
      return byte_array.pack('C*')
    when ORiN3BinaryConverter::DataType::NullableInt32Array
      byte_array = Array.new(1 + 4 + (data.length * 5), 0)
      byte_array[0] = ORiN3BinaryConverter::DataType::NullableInt32Array
      byte_array[1..4] = [data.length].pack('l<').bytes
      data.each_with_index do |item, index|
        if !item.nil? && (item < -2_147_483_648 || item > 2_147_483_647)
          raise ArgumentError, "Value #{item} is out of range for Int32. It must be between -2147483648 and 2147483647."
        end
        if !item.nil?
          byte_array[5 + (index * 5)] = 1
          byte_array[5 + (index * 5) + 1, 4] = [item].pack('l<').bytes
        end
      end
      return byte_array.pack('C*')
    when ORiN3BinaryConverter::DataType::NullableUInt64Array
      byte_array = Array.new(1 + 4 + (data.length * 9), 0)
      byte_array[0] = ORiN3BinaryConverter::DataType::NullableUInt64Array
      byte_array[1..4] = [data.length].pack('l<').bytes
      data.each_with_index do |item, index|
        if !item.nil? && (item < 0 || item > 18_446_744_073_709_551_615)
          raise ArgumentError, "Value #{item} is out of range for UInt64. It must be between 0 and 18446744073709551615."
        end
        if !item.nil?
          byte_array[5 + (index * 9)] = 1
          byte_array[5 + (index * 9) + 1, 8] = [item].pack('Q<').bytes
        end
      end
      return byte_array.pack('C*')
    when ORiN3BinaryConverter::DataType::NullableInt64Array
      byte_array = Array.new(1 + 4 + (data.length * 9), 0)
      byte_array[0] = ORiN3BinaryConverter::DataType::NullableInt64Array
      byte_array[1..4] = [data.length].pack('l<').bytes
      data.each_with_index do |item, index|
        if !item.nil? && (item < -9_223_372_036_854_775_808 || item > 9_223_372_036_854_775_807)
          raise ArgumentError, "Value #{item} is out of range for Int64. It must be between -9223372036854775808 and 9223372036854775807."
        end
        if !item.nil?
          byte_array[5 + (index * 9)] = 1
          byte_array[5 + (index * 9) + 1, 8] = [item].pack('q<').bytes
        end
      end
      return byte_array.pack('C*')
    when ORiN3BinaryConverter::DataType::NullableFloatArray
      byte_array = Array.new(1 + 4 + (data.length * 5), 0)
      byte_array[0] = ORiN3BinaryConverter::DataType::NullableFloatArray
      byte_array[1..4] = [data.length].pack('l<').bytes
      data.each_with_index do |item, index|
        if !item.nil?
          byte_array[5 + (index * 5)] = 1
          byte_array[5 + (index * 5) + 1, 4] = [item].pack('e').bytes
        end
      end
      return byte_array.pack('C*')
    when ORiN3BinaryConverter::DataType::NullableDoubleArray
      byte_array = Array.new(1 + 4 + (data.length * 9), 0)
      byte_array[0] = ORiN3BinaryConverter::DataType::NullableDoubleArray
      byte_array[1..4] = [data.length].pack('l<').bytes
      data.each_with_index do |item, index|
        if !item.nil?
          byte_array[5 + (index * 9)] = 1
          byte_array[5 + (index * 9) + 1, 8] = [item].pack('E').bytes
        end
      end
      return byte_array.pack('C*')
    else
      raise ArgumentError, "Unsupported data type"
    end
  end
end