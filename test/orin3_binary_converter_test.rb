require 'logger'
require 'minitest/autorun'
require 'minitest/hooks/default'
require 'minitest/autorun'
require 'uri'
require_relative '../lib/grpc/orin3/provider'

$logger = Logger.new(STDOUT)
$logger.formatter = proc do |severity, datetime, progname, msg|
  "[#{datetime}] #{severity}: #{msg}\n"
end

class ORiN3ProviderTest < Minitest::Test
  include Minitest::Hooks

  def before_all
    puts "......................."
    $logger.info "* before_all called."
    $logger.info "* before_all finished."
  end

  def after_all
    puts "......................."
    $logger.info "* after_all called."
    $logger.info "* after_all finished."
  end

  def setup
    puts "......................."
    $logger.info "* setup called."
  end

  def teardown
    $logger.info "* teardown called."
  end

  def do_test(data, binary, type)
    binary = binary.pack('C*')
    actual = ORiN3BinaryConverter.serialize(data, type)
    $logger.info "data: #{data} => #{actual.unpack("C*").map { |byte| "%02x" % byte }.join}"
    assert_equal binary, actual
    actual = ORiN3BinaryConverter.deserialize(binary)
    $logger.info "#{binary.inspect} => #{actual}[#{actual.class.name}]"
    assert_equal data, actual
  end

  def do_test_out_of_range(data, type)
    error = assert_raises(ArgumentError) do
      ORiN3BinaryConverter.serialize(data, type)
    end
    $logger.info "Target: #{data} => #{error.message}"
  end

  def test_nil
    $logger.info "* test_nil called."
    do_test(nil, [ 0 ], ORiN3BinaryConverter::DataType::Nil)
  end

  def test_bool
    $logger.info "* test_bool called."
    do_test(true, [ 2, 1 ], ORiN3BinaryConverter::DataType::Bool)
    do_test(false, [ 2, 0 ], ORiN3BinaryConverter::DataType::Bool)
  end

  def test_bool_array
    $logger.info "* test_bool_array called."
    do_test([ true, false, true ], [ 3, 3, 0, 0, 0, 1, 0, 1 ], ORiN3BinaryConverter::DataType::BoolArray)
  end

  def test_nullable_bool_array
    $logger.info "* test_nullable_bool_array called."
    do_test([ true, false, nil, true ], [ 5, 4, 0, 0, 0, 1, 0, 2, 1 ], ORiN3BinaryConverter::DataType::NullableBoolArray)
  end

  def test_uint8
    $logger.info "* test_uint8 called."
    do_test(0, [ 6, 0 ], ORiN3BinaryConverter::DataType::UInt8)
    do_test(1, [ 6, 1 ], ORiN3BinaryConverter::DataType::UInt8)
    do_test(255, [ 6, 255 ], ORiN3BinaryConverter::DataType::UInt8)
    do_test_out_of_range(-1, ORiN3BinaryConverter::DataType::UInt8)
    do_test_out_of_range(256, ORiN3BinaryConverter::DataType::UInt8)
  end

  def test_uint8_array
    $logger.info "* test_uint8_array called."
    do_test([ 0, 1, 255 ], [ 7, 3, 0, 0, 0, 0, 1, 255 ], ORiN3BinaryConverter::DataType::UInt8Array)
    do_test_out_of_range([ 1, 256 ], ORiN3BinaryConverter::DataType::UInt8Array)
    do_test_out_of_range([ -1, 1 ], ORiN3BinaryConverter::DataType::UInt8Array)
  end

  def test_nullable_uint8_array
    $logger.info "* test_nullable_uint8_array called."
    do_test([ nil ], [ 9, 1, 0, 0, 0, 0, 0 ], ORiN3BinaryConverter::DataType::NullableUInt8Array)
    do_test([ 0, 1, nil, 255 ], [ 9, 4, 0, 0, 0, 1, 0, 1, 1, 0, 0, 1, 255 ], ORiN3BinaryConverter::DataType::NullableUInt8Array)
    do_test_out_of_range([ nil, 256 ], ORiN3BinaryConverter::DataType::NullableUInt8Array)
    do_test_out_of_range([ -1, nil ], ORiN3BinaryConverter::DataType::NullableUInt8Array)
  end

  def test_uint16
    $logger.info "* test_uint16 called."
    do_test(0, [ 10, 0, 0 ], ORiN3BinaryConverter::DataType::UInt16)
    do_test(1, [ 10, 1, 0 ], ORiN3BinaryConverter::DataType::UInt16)
    do_test(65535, [ 10, 255, 255 ], ORiN3BinaryConverter::DataType::UInt16)
    do_test_out_of_range(-1, ORiN3BinaryConverter::DataType::UInt16)
    do_test_out_of_range(65536, ORiN3BinaryConverter::DataType::UInt16)
  end

  def test_uint16_array
    $logger.info "* test_uint16_array called."
    do_test([ 0, 1, 65535 ], [ 11, 3, 0, 0, 0, 0, 0, 1, 0, 255, 255 ], ORiN3BinaryConverter::DataType::UInt16Array)
    do_test_out_of_range([ 1, 65536 ], ORiN3BinaryConverter::DataType::UInt16Array)
    do_test_out_of_range([ -1, 1 ], ORiN3BinaryConverter::DataType::UInt16Array)
  end

  def test_nullable_uint16_array
    $logger.info "* test_nullable_uint16_array called."
    do_test([ nil ], [ 13, 1, 0, 0, 0, 0, 0, 0 ], ORiN3BinaryConverter::DataType::NullableUInt16Array)
    do_test([ 0, 1, nil, 65535 ], [ 13, 4, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 1, 255, 255 ], ORiN3BinaryConverter::DataType::NullableUInt16Array)
    do_test_out_of_range([ nil, 65536 ], ORiN3BinaryConverter::DataType::NullableUInt16Array)
    do_test_out_of_range([ -1, nil ], ORiN3BinaryConverter::DataType::NullableUInt16Array)
  end

  def test_uint32
    $logger.info "* test_uint32 called."
    do_test(0, [ 14, 0, 0, 0, 0 ], ORiN3BinaryConverter::DataType::UInt32)
    do_test(1, [ 14, 1, 0, 0, 0 ], ORiN3BinaryConverter::DataType::UInt32)
    do_test(4294967295, [ 14, 255, 255, 255, 255 ], ORiN3BinaryConverter::DataType::UInt32)
    do_test_out_of_range(-1, ORiN3BinaryConverter::DataType::UInt32)
    do_test_out_of_range(4294967296, ORiN3BinaryConverter::DataType::UInt32)
  end

  def test_uint32_array
    $logger.info "* test_uint32_array called."
    do_test([ 0, 1, 4294967295 ], [ 15, 3, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 255, 255, 255, 255 ], ORiN3BinaryConverter::DataType::UInt32Array)
    do_test_out_of_range([ 1, 4294967296 ], ORiN3BinaryConverter::DataType::UInt32Array)
    do_test_out_of_range([ -1, 1 ], ORiN3BinaryConverter::DataType::UInt32Array)
  end

  def test_nullable_uint32_array
    $logger.info "* test_nullable_uint32_array called."
    do_test([ nil ], [ 17, 1, 0, 0, 0, 0, 0, 0, 0, 0 ], ORiN3BinaryConverter::DataType::NullableUInt32Array)
    do_test([ 0, 1, nil, 4294967295 ], [ 17, 4, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 255, 255, 255, 255 ], ORiN3BinaryConverter::DataType::NullableUInt32Array)
    do_test_out_of_range([ nil, 4294967296 ], ORiN3BinaryConverter::DataType::NullableUInt32Array)
    do_test_out_of_range([ -1, nil ], ORiN3BinaryConverter::DataType::NullableUInt32Array)
  end

  def test_uint64
    $logger.info "* test_uint64 called."
    do_test(0, [ 18, 0, 0, 0, 0, 0, 0, 0, 0 ], ORiN3BinaryConverter::DataType::UInt64)
    do_test(1, [ 18, 1, 0, 0, 0, 0, 0, 0, 0 ], ORiN3BinaryConverter::DataType::UInt64)
    do_test(18_446_744_073_709_551_615, [ 18, 255, 255, 255, 255, 255, 255, 255, 255 ], ORiN3BinaryConverter::DataType::UInt64)
    do_test_out_of_range(-1, ORiN3BinaryConverter::DataType::UInt64)
    do_test_out_of_range(18_446_744_073_709_551_616, ORiN3BinaryConverter::DataType::UInt64)
  end

  def test_uint64_array
    $logger.info "* test_uint64_array called."
    do_test([ 0, 1, 18_446_744_073_709_551_615 ], [ 19, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 255, 255, 255, 255, 255, 255, 255, 255 ], ORiN3BinaryConverter::DataType::UInt64Array)
    do_test_out_of_range([ 1, 18_446_744_073_709_551_616 ], ORiN3BinaryConverter::DataType::UInt64Array)
    do_test_out_of_range([ -1, 1 ], ORiN3BinaryConverter::DataType::UInt64Array)
  end

  def test_nullable_uint64_array
    $logger.info "* test_nullable_uint64_array called."
    do_test([ nil ], [ 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], ORiN3BinaryConverter::DataType::NullableUInt64Array)
    do_test([ 0, 1, nil, 18_446_744_073_709_551_615 ], [ 21, 4, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 255, 255, 255, 255, 255, 255, 255, 255 ], ORiN3BinaryConverter::DataType::NullableUInt64Array)
    do_test_out_of_range([ nil, 18_446_744_073_709_551_616 ], ORiN3BinaryConverter::DataType::NullableUInt64Array)
    do_test_out_of_range([ -1, nil ], ORiN3BinaryConverter::DataType::NullableUInt64Array)
  end

  def test_int8
    $logger.info "* test_int8 called."
    do_test(-1, [ 22, 255 ], ORiN3BinaryConverter::DataType::Int8)
    do_test(-128, [ 22, 128 ], ORiN3BinaryConverter::DataType::Int8)
    do_test(127, [ 22, 127 ], ORiN3BinaryConverter::DataType::Int8)
    do_test_out_of_range(128, ORiN3BinaryConverter::DataType::Int8)
    do_test_out_of_range(-129, ORiN3BinaryConverter::DataType::Int8)
  end

  def test_int8_array
    $logger.info "* test_int8_array called."
    do_test([ -1, -128, 127 ], [ 23, 3, 0, 0, 0, 255, 128, 127 ], ORiN3BinaryConverter::DataType::Int8Array)
    do_test_out_of_range([ 1, 128 ], ORiN3BinaryConverter::DataType::Int8Array)
    do_test_out_of_range([ -129, 1 ], ORiN3BinaryConverter::DataType::Int8Array)
  end

  def test_nullable_int8_array
    $logger.info "* test_nullable_int8_array called."
    do_test([ nil ], [ 25, 1, 0, 0, 0, 0, 0 ], ORiN3BinaryConverter::DataType::NullableInt8Array)
    do_test([ -1, -128, nil, 127 ], [ 25, 4, 0, 0, 0, 1, 255, 1, 128, 0, 0, 1, 127 ], ORiN3BinaryConverter::DataType::NullableInt8Array)
    do_test_out_of_range([ nil, 128 ], ORiN3BinaryConverter::DataType::NullableInt8Array)
    do_test_out_of_range([ -129, nil ], ORiN3BinaryConverter::DataType::NullableInt8Array)
  end

  def test_int16
    $logger.info "* test_int16 called."
    do_test(-1, [ 26, 255, 255 ], ORiN3BinaryConverter::DataType::Int16)
    do_test(-32768, [ 26, 0, 128 ], ORiN3BinaryConverter::DataType::Int16)
    do_test(32767, [ 26, 255, 127 ], ORiN3BinaryConverter::DataType::Int16)
    do_test_out_of_range(32768, ORiN3BinaryConverter::DataType::Int16)
    do_test_out_of_range(-32769, ORiN3BinaryConverter::DataType::Int16)
  end

  def test_int16_array
    $logger.info "* test_int16_array called."
    do_test([ -1, -32768, 32767 ], [ 27, 3, 0, 0, 0, 255, 255, 0, 128, 255, 127 ], ORiN3BinaryConverter::DataType::Int16Array)
    do_test_out_of_range([ 1, 32768 ], ORiN3BinaryConverter::DataType::Int16Array)
    do_test_out_of_range([ -32769, 1 ], ORiN3BinaryConverter::DataType::Int16Array)
  end

  def test_nullable_int16_array
    $logger.info "* test_nullable_int16_array called."
    do_test([ nil ], [ 29, 1, 0, 0, 0, 0, 0, 0 ], ORiN3BinaryConverter::DataType::NullableInt16Array)
    do_test([ -1, -32768, nil, 32767 ], [ 29, 4, 0, 0, 0, 1, 255, 255, 1, 0, 128, 0, 0, 0, 1, 255, 127 ], ORiN3BinaryConverter::DataType::NullableInt16Array)
    do_test_out_of_range([ nil, 32768 ], ORiN3BinaryConverter::DataType::NullableInt16Array)
    do_test_out_of_range([ -32769, nil ], ORiN3BinaryConverter::DataType::NullableInt16Array)
  end

  def test_int32
    $logger.info "* test_int32 called."
    do_test(-1, [ 30, 255, 255, 255, 255 ], ORiN3BinaryConverter::DataType::Int32)
    do_test(-2147483648, [ 30, 0, 0, 0, 128 ], ORiN3BinaryConverter::DataType::Int32)
    do_test(2147483647, [ 30, 255, 255, 255, 127 ], ORiN3BinaryConverter::DataType::Int32)
    do_test_out_of_range(2147483648, ORiN3BinaryConverter::DataType::Int32)
    do_test_out_of_range(-2147483649, ORiN3BinaryConverter::DataType::Int32)
  end

  def test_int32_array
    $logger.info "* test_int32_array called."
    do_test([ -1, -2147483648, 2147483647 ], [ 31, 3, 0, 0, 0, 255, 255, 255, 255, 0, 0, 0, 128, 255, 255, 255, 127 ], ORiN3BinaryConverter::DataType::Int32Array)
    do_test_out_of_range([ 1, 2147483648 ], ORiN3BinaryConverter::DataType::Int32Array)
    do_test_out_of_range([ -2147483649, 1 ], ORiN3BinaryConverter::DataType::Int32Array)
  end

  def test_nullable_int32_array
    $logger.info "* test_nullable_int32_array called."
    do_test([ nil ], [ 33, 1, 0, 0, 0, 0, 0, 0, 0, 0 ], ORiN3BinaryConverter::DataType::NullableInt32Array)
    do_test([ -1, -2147483648, nil, 2147483647 ], [ 33, 4, 0, 0, 0, 1, 255, 255, 255, 255, 1, 0, 0, 0, 128, 0, 0, 0, 0, 0, 1, 255, 255, 255, 127 ], ORiN3BinaryConverter::DataType::NullableInt32Array)
    do_test_out_of_range([ nil, 2147483648 ], ORiN3BinaryConverter::DataType::NullableInt32Array)
    do_test_out_of_range([ -2147483649, nil ], ORiN3BinaryConverter::DataType::NullableInt32Array)
  end

  def test_int64
    $logger.info "* test_int64 called."
    do_test(-1, [ 34, 255, 255, 255, 255, 255, 255, 255, 255 ], ORiN3BinaryConverter::DataType::Int64)
    do_test(-9223372036854775808, [ 34, 0, 0, 0, 0, 0, 0, 0, 128 ], ORiN3BinaryConverter::DataType::Int64)
    do_test(9223372036854775807, [ 34, 255, 255, 255, 255, 255, 255, 255, 127 ], ORiN3BinaryConverter::DataType::Int64)
    do_test_out_of_range(9223372036854775808, ORiN3BinaryConverter::DataType::Int64)
    do_test_out_of_range(-9223372036854775809, ORiN3BinaryConverter::DataType::Int64)
  end

  def test_int64_array
    $logger.info "* test_int64_array called."
    do_test([ -1, -9223372036854775808, 9223372036854775807 ], [ 35, 3, 0, 0, 0, 255, 255, 255, 255, 255, 255, 255, 255, 0, 0, 0, 0, 0, 0, 0, 128, 255, 255, 255, 255, 255, 255, 255, 127 ], ORiN3BinaryConverter::DataType::Int64Array)
    do_test_out_of_range([ 1, 9223372036854775808 ], ORiN3BinaryConverter::DataType::Int64Array)
    do_test_out_of_range([ -9223372036854775809, 1 ], ORiN3BinaryConverter::DataType::Int64Array)
  end

  def test_nullable_int64_array
    $logger.info "* test_nullable_int64_array called."
    do_test([ nil ], [ 37, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], ORiN3BinaryConverter::DataType::NullableInt64Array)
    do_test([ -1, -9223372036854775808, nil, 9223372036854775807 ], [ 37, 4, 0, 0, 0, 1, 255, 255, 255, 255, 255, 255, 255, 255, 1, 0, 0, 0, 0, 0, 0, 0, 128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 255, 255, 255, 255, 255, 255, 255, 127 ], ORiN3BinaryConverter::DataType::NullableInt64Array)
    do_test_out_of_range([ nil, 9223372036854775808 ], ORiN3BinaryConverter::DataType::NullableInt64Array)
    do_test_out_of_range([ -9223372036854775809, nil ], ORiN3BinaryConverter::DataType::NullableInt64Array)
  end

  def test_float
    $logger.info "* test_float called."
    do_test(Float::INFINITY, [ 38, 0, 0, 128, 127 ], ORiN3BinaryConverter::DataType::Float)
    do_test(-Float::INFINITY, [ 38, 0, 0, 128, 255 ], ORiN3BinaryConverter::DataType::Float)
    do_test(0.0, [ 38, 0, 0, 0, 0 ], ORiN3BinaryConverter::DataType::Float)
    do_test(1.0, [ 38, 0, 0, 0x80, 0x3F ], ORiN3BinaryConverter::DataType::Float)
  end

  def test_float_array
    $logger.info "* test_float_array called."
    do_test([ Float::INFINITY, -Float::INFINITY, 0.0, 1.0 ], [ 39, 4, 0, 0, 0, 0, 0, 128, 127, 0, 0, 128, 255, 0, 0, 0, 0, 0, 0, 0x80, 0x3F ], ORiN3BinaryConverter::DataType::FloatArray)
  end

  def test_nullable_float_array
    $logger.info "* test_nullable_float_array called."
    do_test([ nil ], [ 41, 1, 0, 0, 0, 0, 0, 0, 0, 0 ], ORiN3BinaryConverter::DataType::NullableFloatArray)
    do_test([ Float::INFINITY, -Float::INFINITY, 0.0, nil, 1.0 ], [ 41, 5, 0, 0, 0, 1, 0, 0, 128, 127, 1, 0, 0, 128, 255, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0x80, 0x3F ], ORiN3BinaryConverter::DataType::NullableFloatArray)
  end

  def test_double
    $logger.info "* test_double called."
    do_test(-1.7976931348623157e+308, [42, 255, 255, 255, 255, 255, 255, 239, 255 ], ORiN3BinaryConverter::DataType::Double)
    do_test(1.7976931348623157e+308, [42, 255, 255, 255, 255, 255, 255, 239, 127 ], ORiN3BinaryConverter::DataType::Double)
    do_test(Float::INFINITY, [42, 0, 0, 0, 0, 0, 0, 240, 127 ], ORiN3BinaryConverter::DataType::Double)
    do_test(-Float::INFINITY, [42, 0, 0, 0, 0, 0, 0, 240, 255 ], ORiN3BinaryConverter::DataType::Double)
    do_test(1.0, [ 42, 0, 0, 0, 0, 0, 0, 240, 63 ], ORiN3BinaryConverter::DataType::Double)
    do_test(0.0, [ 42, 0, 0, 0, 0, 0, 0, 0, 0 ], ORiN3BinaryConverter::DataType::Double)
  end

  def test_double_array
    $logger.info "* test_double_array called."
    do_test([ -1.7976931348623157e+308, 1.7976931348623157e+308, Float::INFINITY, -Float::INFINITY, 1.0, 0.0 ], [
      43, 6, 0, 0, 0,
      255, 255, 255, 255, 255, 255, 239, 255,
      255, 255, 255, 255, 255, 255, 239, 127,
      0, 0, 0, 0, 0, 0, 240, 127,
      0, 0, 0, 0, 0, 0, 240, 255,
      0, 0, 0, 0, 0, 0, 240, 63,
      0, 0, 0, 0, 0, 0, 0, 0 ], ORiN3BinaryConverter::DataType::DoubleArray)
  end

  def test_nullable_double_array
    $logger.info "* test_nullable_double_array called."
    do_test([ nil ], [ 45, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], ORiN3BinaryConverter::DataType::NullableDoubleArray)

    do_test([ -1.7976931348623157e+308, 1.7976931348623157e+308, Float::INFINITY, -Float::INFINITY, 1.0, nil, 0.0 ], [
      45, 7, 0, 0, 0,
      1, 255, 255, 255, 255, 255, 255, 239, 255,
      1, 255, 255, 255, 255, 255, 255, 239, 127,
      1, 0, 0, 0, 0, 0, 0, 240, 127,
      1, 0, 0, 0, 0, 0, 0, 240, 255,
      1, 0, 0, 0, 0, 0, 0, 240, 63,
      0, 0, 0, 0, 0, 0, 0, 0, 0,
      1, 0, 0, 0, 0, 0, 0, 0, 0 ], ORiN3BinaryConverter::DataType::NullableDoubleArray)
  end

  def test_datetime
    $logger.info "* test_datetime called."
    do_test(Time.iso8601("0001-01-01T00:00:00.0000000Z"), [ 48, 0, 0, 0, 0, 0, 0, 0, 0 ], ORiN3BinaryConverter::DataType::DateTime)
    do_test(Time.iso8601("2024-11-27T09:00:00.0000000Z"), [ 48, 0, 168, 163, 223, 193, 14, 221, 8 ], ORiN3BinaryConverter::DataType::DateTime)
  end

  def test_datetime_array
    $logger.info "* test_datetime_array called."
    do_test([ Time.iso8601("0001-01-01T00:00:00.0000000Z"), Time.iso8601("2024-11-27T09:00:00.0000000Z") ], [
      49, 2, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0,
      0, 168, 163, 223, 193, 14, 221, 8 ], ORiN3BinaryConverter::DataType::DateTimeArray)
  end

  def test_nullable_datetime_array
    $logger.info "* test_nullable_datetime_array called."
    do_test([ Time.iso8601("0001-01-01T00:00:00.0000000Z"), nil, Time.iso8601("2024-11-27T09:00:00.0000000Z") ], [
      51, 3, 0, 0, 0,
      1, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0,
      1, 0, 168, 163, 223, 193, 14, 221, 8 ], ORiN3BinaryConverter::DataType::NullableDateTimeArray)
  end

  def test_string
    $logger.info "* test_datetime called."
    do_test("0", [ 46, 1, 0, 0, 0, 0x30 ], ORiN3BinaryConverter::DataType::String)
  end
end