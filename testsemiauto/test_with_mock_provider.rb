require 'logger'
require 'minitest/autorun'
require 'minitest/hooks/default'
require 'minitest/autorun'
require 'uri'
require_relative '../lib/grpc/orin3/provider'
require 'json'

$logger = Logger.new(STDOUT)
$logger.formatter = proc do |severity, datetime, progname, msg|
  "[#{datetime}] #{severity}: #{msg}\n"
end

module ORiN3
  include Grpc::Client::ORiN3
  include Grpc::Client::ORiN3::Provider
end

class ORiN3ProviderTest < Minitest::Test
  include Minitest::Hooks
  
  def before_all
    puts "......................."
    $logger.info "* before_all called."
    @controllers = {}
    @variables = {}

    $logger.info "* wakeup mock provider."
    id = "643D12C8-DCFC-476C-AA15-E8CA004F48E8"
    @version = "1.0.84-beta.8"
    channel = GRPC::Core::Channel.new("localhost:7103", nil, :this_channel_is_insecure)
    remote_engine = ORiN3::RemoteEngine.new(channel)
    result = remote_engine.wakeup_provider(id, @version, "0.0.0.0", 0)
    $logger.info "* wakeup mock provider done. [uri=#{result.provider_information.endpoints[0].uri}]"

    uri = URI.parse(result.provider_information.endpoints[0].uri)
    provider_channerl = GRPC::Core::Channel.new("#{uri.host}:#{uri.port}", nil, :this_channel_is_insecure)
    @root = ORiN3::ORiN3RootObject.attach(provider_channerl)
    $logger.info "* attached to mock provider."

    $logger.info "Root.name: #{@root.name}"
    $logger.info "Root.type_name: #{@root.type_name}"
    $logger.info "Root.option: #{@root.option}"
    $logger.info "Root.created_datetime: #{@root.created_datetime.getlocal}"
    $logger.info "Root.orin3_object_type: #{@root.orin3_object_type}"
    $logger.info "Root.id: #{@root.id}"
    $logger.info "* before_all finished."
  end
  
  def after_all
    puts "......................."
    $logger.info "* after_all called."
    #after_all_core
    $logger.info "* after_all finished."
  end
  
  def setup
    puts "......................."
    $logger.info "* setup called."
  end
  
  def teardown
    $logger.info "* teardown called."
  end

  def self.get_constant_name(value, namespace)
    namespace.constants.each do |const_name|
      return const_name if namespace.const_get(const_name) == value
    end
    nil # 見つからなければ nil を返す
  end

  def after_all_core
    @root.shutdown
  end

  def create_or_get_controller(name)
    if @controllers.key?(name)
      return @controllers[name]
    end
    controller = @root.create_controller(name,
      "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Controller.GeneralPurposeController, ORiN3.Provider.ORiNConsortium.Mock",
      "{ \"@Version\":\"#{@version}\" }")
    $logger.info "Controller created. [name=#{controller.name}]"
    @controllers[name] = controller
    return controller
  end

  def create_or_get_variable(parent, name, option, value_type)
    if @variables.key?(name)
      return @variables[name]
    end
    option_string = "{ \"@Version\":\"#{@version}\" }"
    if !option.nil?
      parsed_data = JSON.parse(option_string)
      # 動的に要素を追加
      option.each do |key, value|
        parsed_data[key] = value
      end
      option_string = JSON.generate(parsed_data)
    end

    hash = {}
    hash[:ORIN3_BOOL] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.BoolVariable, ORiN3.Provider.ORiNConsortium.Mock"
    hash[:ORIN3_UINT8] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.UInt8Variable, ORiN3.Provider.ORiNConsortium.Mock"
    hash[:ORIN3_UINT16] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.UInt16Variable, ORiN3.Provider.ORiNConsortium.Mock"
    hash[:ORIN3_UINT32] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.UInt32Variable, ORiN3.Provider.ORiNConsortium.Mock"
    hash[:ORIN3_UINT64] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.UInt64Variable, ORiN3.Provider.ORiNConsortium.Mock"
    hash[:ORIN3_INT8] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.Int8Variable, ORiN3.Provider.ORiNConsortium.Mock"
    hash[:ORIN3_INT16] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.Int16Variable, ORiN3.Provider.ORiNConsortium.Mock"
    hash[:ORIN3_INT32] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.Int32Variable, ORiN3.Provider.ORiNConsortium.Mock"
    hash[:ORIN3_INT64] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.Int64Variable, ORiN3.Provider.ORiNConsortium.Mock"
    hash[:ORIN3_FLOAT] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.FloatVariable, ORiN3.Provider.ORiNConsortium.Mock"
    hash[:ORIN3_DOUBLE] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.DoubleVariable, ORiN3.Provider.ORiNConsortium.Mock"
    hash[:ORIN3_STRING] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.StringVariable, ORiN3.Provider.ORiNConsortium.Mock"
    hash[:ORIN3_DATETIME] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.DateTimeVariable, ORiN3.Provider.ORiNConsortium.Mock"
    
    hash[:ORIN3_NULLABLE_BOOL] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.NullableBoolVariable, ORiN3.Provider.ORiNConsortium.Mock"
    hash[:ORIN3_NULLABLE_UINT8] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.NullableUInt8Variable, ORiN3.Provider.ORiNConsortium.Mock"
    hash[:ORIN3_NULLABLE_UINT16] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.NullableUInt16Variable, ORiN3.Provider.ORiNConsortium.Mock"
    hash[:ORIN3_NULLABLE_UINT32] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.NullableUInt32Variable, ORiN3.Provider.ORiNConsortium.Mock"
    hash[:ORIN3_NULLABLE_UINT64] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.NullableUInt64Variable, ORiN3.Provider.ORiNConsortium.Mock"
    hash[:ORIN3_NULLABLE_INT8] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.NullableInt8Variable, ORiN3.Provider.ORiNConsortium.Mock"
    hash[:ORIN3_NULLABLE_INT16] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.NullableInt16Variable, ORiN3.Provider.ORiNConsortium.Mock"
    hash[:ORIN3_NULLABLE_INT32] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.NullableInt32Variable, ORiN3.Provider.ORiNConsortium.Mock"
    hash[:ORIN3_NULLABLE_INT64] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.NullableInt64Variable, ORiN3.Provider.ORiNConsortium.Mock"
    hash[:ORIN3_NULLABLE_FLOAT] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.NullableFloatVariable, ORiN3.Provider.ORiNConsortium.Mock"
    hash[:ORIN3_NULLABLE_DOUBLE] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.NullableDoubleVariable, ORiN3.Provider.ORiNConsortium.Mock"
    hash[:ORIN3_NULLABLE_DATETIME] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.NullableDateTimeVariable, ORiN3.Provider.ORiNConsortium.Mock"

    hash[:ORIN3_BOOL_ARRAY] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.BoolArrayVariable, ORiN3.Provider.ORiNConsortium.Mock"
    hash[:ORIN3_UINT8_ARRAY] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.UInt8ArrayVariable, ORiN3.Provider.ORiNConsortium.Mock"
    hash[:ORIN3_UINT16_ARRAY] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.UInt16ArrayVariable, ORiN3.Provider.ORiNConsortium.Mock"
    hash[:ORIN3_UINT32_ARRAY] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.UInt32ArrayVariable, ORiN3.Provider.ORiNConsortium.Mock"
    hash[:ORIN3_UINT64_ARRAY] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.UInt64ArrayVariable, ORiN3.Provider.ORiNConsortium.Mock"
    hash[:ORIN3_INT8_ARRAY] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.Int8ArrayVariable, ORiN3.Provider.ORiNConsortium.Mock"
    hash[:ORIN3_INT16_ARRAY] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.Int16ArrayVariable, ORiN3.Provider.ORiNConsortium.Mock"
    hash[:ORIN3_INT32_ARRAY] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.Int32ArrayVariable, ORiN3.Provider.ORiNConsortium.Mock"
    hash[:ORIN3_INT64_ARRAY] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.Int64ArrayVariable, ORiN3.Provider.ORiNConsortium.Mock"
    hash[:ORIN3_FLOAT_ARRAY] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.FloatArrayVariable, ORiN3.Provider.ORiNConsortium.Mock"
    hash[:ORIN3_DOUBLE_ARRAY] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.DoubleArrayVariable, ORiN3.Provider.ORiNConsortium.Mock"
    hash[:ORIN3_STRING_ARRAY] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.StringArrayVariable, ORiN3.Provider.ORiNConsortium.Mock"
    hash[:ORIN3_DATETIME_ARRAY] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.DateTimeArrayVariable, ORiN3.Provider.ORiNConsortium.Mock"

    hash[:ORIN3_NULLABLE_BOOL_ARRAY] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.NullableBoolArrayVariable, ORiN3.Provider.ORiNConsortium.Mock"
    hash[:ORIN3_NULLABLE_UINT8_ARRAY] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.NullableUInt8ArrayVariable, ORiN3.Provider.ORiNConsortium.Mock"
    hash[:ORIN3_NULLABLE_UINT16_ARRAY] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.NullableUInt16ArrayVariable, ORiN3.Provider.ORiNConsortium.Mock"
    hash[:ORIN3_NULLABLE_UINT32_ARRAY] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.NullableUInt32ArrayVariable, ORiN3.Provider.ORiNConsortium.Mock"
    hash[:ORIN3_NULLABLE_UINT64_ARRAY] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.NullableUInt64ArrayVariable, ORiN3.Provider.ORiNConsortium.Mock"
    hash[:ORIN3_NULLABLE_INT8_ARRAY] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.NullableInt8ArrayVariable, ORiN3.Provider.ORiNConsortium.Mock"
    hash[:ORIN3_NULLABLE_INT16_ARRAY] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.NullableInt16ArrayVariable, ORiN3.Provider.ORiNConsortium.Mock"
    hash[:ORIN3_NULLABLE_INT32_ARRAY] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.NullableInt32ArrayVariable, ORiN3.Provider.ORiNConsortium.Mock"
    hash[:ORIN3_NULLABLE_INT64_ARRAY] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.NullableInt64ArrayVariable, ORiN3.Provider.ORiNConsortium.Mock"
    hash[:ORIN3_NULLABLE_FLOAT_ARRAY] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.NullableFloatArrayVariable, ORiN3.Provider.ORiNConsortium.Mock"
    hash[:ORIN3_NULLABLE_DOUBLE_ARRAY] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.NullableDoubleArrayVariable, ORiN3.Provider.ORiNConsortium.Mock"
    hash[:ORIN3_NULLABLE_DATETIME_ARRAY] = "ORiN3.Provider.ORiNConsortium.Mock.O3Object.Variable.NullableDateTimeArrayVariable, ORiN3.Provider.ORiNConsortium.Mock"
    variable = parent.create_variable(name, hash[value_type], option_string, value_type)
    $logger.info "Variable created. [name=#{variable.name}]"
    @variables[name] = variable
    $logger.info "Variable.name: #{variable.name}"
    $logger.info "Variable.type_name: #{variable.type_name}"
    $logger.info "Variable.option: #{variable.option}"
    $logger.info "Variable.created_datetime: #{variable.created_datetime.getlocal}"
    $logger.info "Variable.orin3_object_type: #{variable.orin3_object_type}"
    $logger.info "Variable.id: #{variable.id}"
    return variable
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

  TAG_TEST_DATA = [
    { name: "TAG_TEST_DATA", type: ORiN3BinaryConverter::DataType::Nil, value: { nil: nil } },
    { name: "TAG_TEST_DATA", type: ORiN3BinaryConverter::DataType::Bool, value: { true: false, false: true } },
    { name: "TAG_TEST_DATA", type: ORiN3BinaryConverter::DataType::UInt8, value: { min: UINT8_MIN, common: 1, max: UINT8_MAX } },
    { name: "TAG_TEST_DATA", type: ORiN3BinaryConverter::DataType::UInt16, value: { min: UINT16_MIN, common: 1, max: UINT16_MAX } },
    { name: "TAG_TEST_DATA", type: ORiN3BinaryConverter::DataType::UInt32, value: { min: UINT32_MIN, common: 1, max: UINT32_MAX } },
    { name: "TAG_TEST_DATA", type: ORiN3BinaryConverter::DataType::UInt64, value: { min: UINT64_MIN, common: 1, max: UINT64_MAX } },
    { name: "TAG_TEST_DATA", type: ORiN3BinaryConverter::DataType::Int8, value: { min: INT8_MIN, common: 1, max: INT8_MAX } },
    { name: "TAG_TEST_DATA", type: ORiN3BinaryConverter::DataType::Int16, value: { min: INT16_MIN, common: 1, max: INT16_MAX } },
    { name: "TAG_TEST_DATA", type: ORiN3BinaryConverter::DataType::Int32, value: { min: INT32_MIN, common: 1, max: INT32_MAX } },
    { name: "TAG_TEST_DATA", type: ORiN3BinaryConverter::DataType::Int64, value: { min: INT64_MIN, common: 1, max: INT32_MAX } },
    { name: "TAG_TEST_DATA", type: ORiN3BinaryConverter::DataType::Float, value: { common1: 0.0, common: 1.0 } },
    { name: "TAG_TEST_DATA", type: ORiN3BinaryConverter::DataType::Double, value: { min: DOUBLE_MIN, common: 1.0, max: DOUBLE_MAX } },
    { name: "TAG_TEST_DATA", type: ORiN3BinaryConverter::DataType::DateTime, value: { common: Time.utc(1, 1, 1, 0, 0, 0), common2: Time.utc(9999, 12, 31, 23, 59, 59) } },
    #{ name: "TAG_TEST_DATA", type: ORiN3BinaryConverter::DataType::String, value: { common: "abc𩸽123", nil: nil } }, # stringのnullの扱いに問題あり
    # Array
    { name: "TAG_TEST_DATA_ARRAY", type: ORiN3BinaryConverter::DataType::BoolArray, value: { common: [ false, true ] } },
    { name: "TAG_TEST_DATA_ARRAY", type: ORiN3BinaryConverter::DataType::UInt8Array, value: { common: [ UINT8_MIN, 1, UINT8_MAX ] } },
    { name: "TAG_TEST_DATA_ARRAY", type: ORiN3BinaryConverter::DataType::UInt16Array, value: { common: [ UINT16_MIN, 1, UINT16_MAX ] } },
    { name: "TAG_TEST_DATA_ARRAY", type: ORiN3BinaryConverter::DataType::UInt32Array, value: { common: [ UINT32_MIN, 1, UINT32_MAX ] } },
    { name: "TAG_TEST_DATA_ARRAY", type: ORiN3BinaryConverter::DataType::UInt64Array, value: { common: [ UINT64_MIN, 1, UINT64_MAX ] } },
    { name: "TAG_TEST_DATA_ARRAY", type: ORiN3BinaryConverter::DataType::Int8Array, value: { common: [ INT8_MIN, 0, INT8_MAX ] } },
    { name: "TAG_TEST_DATA_ARRAY", type: ORiN3BinaryConverter::DataType::Int16Array, value: { common: [ INT16_MIN, 0, INT16_MAX ] } },
    { name: "TAG_TEST_DATA_ARRAY", type: ORiN3BinaryConverter::DataType::Int32Array, value: { common: [ INT32_MIN, 0, INT32_MAX ] } },
    { name: "TAG_TEST_DATA_ARRAY", type: ORiN3BinaryConverter::DataType::Int64Array, value: { common: [ INT64_MIN, 0, INT32_MAX ] } },
    { name: "TAG_TEST_DATA_ARRAY", type: ORiN3BinaryConverter::DataType::FloatArray, value: { common: [ 0.0, 1.0 ] } },
    { name: "TAG_TEST_DATA_ARRAY", type: ORiN3BinaryConverter::DataType::DoubleArray, value: { common: [ DOUBLE_MIN, 0.0, DOUBLE_MAX ] } },
    { name: "TAG_TEST_DATA_ARRAY", type: ORiN3BinaryConverter::DataType::DateTimeArray, value: { common: [ Time.utc(1, 1, 1, 0, 0, 0), Time.utc(9999, 12, 31, 23, 59, 59) ] } },
    #  { name: "TAG_TEST_DATA_ARRAY", type: ORiN3BinaryConverter::DataType::StringArray, value: { common: [ "abc", "𩸽", nil ] } }, # stringのnullの扱いに問題あり
    # NullableArray
    { name: "TAG_TEST_DATA_NULLABLE_ARRAY", type: ORiN3BinaryConverter::DataType::NullableBoolArray, value: { common: [ false, nil, true ] } },
    { name: "TAG_TEST_DATA_NULLABLE_ARRAY", type: ORiN3BinaryConverter::DataType::NullableUInt8Array, value: { common: [ UINT8_MIN, 1, nil, UINT8_MAX ] } },
    { name: "TAG_TEST_DATA_NULLABLE_ARRAY", type: ORiN3BinaryConverter::DataType::NullableUInt16Array, value: { common: [ UINT16_MIN, 1, nil, UINT16_MAX ] } },
    { name: "TAG_TEST_DATA_NULLABLE_ARRAY", type: ORiN3BinaryConverter::DataType::NullableUInt32Array, value: { common: [ UINT32_MIN, 1, nil, UINT32_MAX ] } },
    { name: "TAG_TEST_DATA_NULLABLE_ARRAY", type: ORiN3BinaryConverter::DataType::NullableUInt64Array, value: { common: [ UINT64_MIN, 1, nil, UINT64_MAX ] } },
    { name: "TAG_TEST_DATA_NULLABLE_ARRAY", type: ORiN3BinaryConverter::DataType::NullableInt8Array, value: { common: [ INT8_MIN, 0, nil, INT8_MAX ] } },
    { name: "TAG_TEST_DATA_NULLABLE_ARRAY", type: ORiN3BinaryConverter::DataType::NullableInt16Array, value: { common: [ INT16_MIN, 0, nil, INT16_MAX ] } },
    { name: "TAG_TEST_DATA_NULLABLE_ARRAY", type: ORiN3BinaryConverter::DataType::NullableInt32Array, value: { common: [ INT32_MIN, 0, nil, INT32_MAX ] } },
    { name: "TAG_TEST_DATA_NULLABLE_ARRAY", type: ORiN3BinaryConverter::DataType::NullableInt64Array, value: { common: [ INT64_MIN, 0, nil, INT32_MAX ] } },
    { name: "TAG_TEST_DATA_NULLABLE_ARRAY", type: ORiN3BinaryConverter::DataType::NullableFloatArray, value: { common: [ 0.0, nil, 1.0 ] } },
    #{ name: "TAG_TEST_DATA_NULLABLE_ARRAY", type: ORiN3BinaryConverter::DataType::NullableDoubleArray, value: { common: [ DOUBLE_MIN, 0.0, nil, DOUBLE_MAX ] } },
    #{ name: "TAG_TEST_DATA_NULLABLE_ARRAY", type: ORiN3BinaryConverter::DataType::NullableDateTimeArray, value: { common: [ Time.utc(1, 1, 1, 0, 0, 0), nil, Time.utc(9999, 12, 31, 23, 59, 59) ] } },
  ] 

  TAG_TEST_DATA.each do |data|
    name = get_constant_name(data[:type], ORiN3BinaryConverter::DataType)
    define_method("test_tag_#{name}") do
      $logger.info "* test_tag_#{name} called."
      controller = create_or_get_controller(data[:name])
      data[:value].each do |key, value|
        tag_name ="#{name}_#{key}"
        controller.set_tag(tag_name, value, data[:type])
        tag = controller.get_tag(tag_name)
        $logger.info "name: #{tag_name}, data type: #{tag.class.name}, value: #{tag}"
        if value.nil?
          assert_nil tag
        else
          assert_equal value, tag
        end
      end
    end
  end

  TAG_NIL_TEST_DATA = [
    { name: "TAG_NIL_TEST_DATA", type: ORiN3BinaryConverter::DataType::Bool },
    { name: "TAG_NIL_TEST_DATA", type: ORiN3BinaryConverter::DataType::UInt8 },
    { name: "TAG_NIL_TEST_DATA", type: ORiN3BinaryConverter::DataType::UInt16 },
    { name: "TAG_NIL_TEST_DATA", type: ORiN3BinaryConverter::DataType::UInt32 },
    { name: "TAG_NIL_TEST_DATA", type: ORiN3BinaryConverter::DataType::UInt64 },
    { name: "TAG_NIL_TEST_DATA", type: ORiN3BinaryConverter::DataType::Int8 },
    { name: "TAG_NIL_TEST_DATA", type: ORiN3BinaryConverter::DataType::Int16 },
    { name: "TAG_NIL_TEST_DATA", type: ORiN3BinaryConverter::DataType::Int32 },
    { name: "TAG_NIL_TEST_DATA", type: ORiN3BinaryConverter::DataType::Int64 },
    { name: "TAG_NIL_TEST_DATA", type: ORiN3BinaryConverter::DataType::Float },
    { name: "TAG_NIL_TEST_DATA", type: ORiN3BinaryConverter::DataType::Double },
    { name: "TAG_NIL_TEST_DATA", type: ORiN3BinaryConverter::DataType::DateTime },
    { name: "TAG_NIL_TEST_DATA", type: ORiN3BinaryConverter::DataType::BoolArray },
    { name: "TAG_NIL_TEST_DATA", type: ORiN3BinaryConverter::DataType::UInt8Array },
    { name: "TAG_NIL_TEST_DATA", type: ORiN3BinaryConverter::DataType::UInt16Array },
    { name: "TAG_NIL_TEST_DATA", type: ORiN3BinaryConverter::DataType::UInt32Array },
    { name: "TAG_NIL_TEST_DATA", type: ORiN3BinaryConverter::DataType::UInt64Array },
    { name: "TAG_NIL_TEST_DATA", type: ORiN3BinaryConverter::DataType::Int8Array },
    { name: "TAG_NIL_TEST_DATA", type: ORiN3BinaryConverter::DataType::Int16Array },
    { name: "TAG_NIL_TEST_DATA", type: ORiN3BinaryConverter::DataType::Int32Array },
    { name: "TAG_NIL_TEST_DATA", type: ORiN3BinaryConverter::DataType::Int64Array },
    { name: "TAG_NIL_TEST_DATA", type: ORiN3BinaryConverter::DataType::FloatArray },
    { name: "TAG_NIL_TEST_DATA", type: ORiN3BinaryConverter::DataType::DoubleArray },
    { name: "TAG_NIL_TEST_DATA", type: ORiN3BinaryConverter::DataType::DateTimeArray },
    { name: "TAG_NIL_TEST_DATA", type: ORiN3BinaryConverter::DataType::StringArray },
    { name: "TAG_NIL_TEST_DATA", type: ORiN3BinaryConverter::DataType::NullableBoolArray },
    { name: "TAG_NIL_TEST_DATA", type: ORiN3BinaryConverter::DataType::NullableUInt8Array },
    { name: "TAG_NIL_TEST_DATA", type: ORiN3BinaryConverter::DataType::NullableUInt16Array },
    { name: "TAG_NIL_TEST_DATA", type: ORiN3BinaryConverter::DataType::NullableUInt32Array },
    { name: "TAG_NIL_TEST_DATA", type: ORiN3BinaryConverter::DataType::NullableUInt64Array },
    { name: "TAG_NIL_TEST_DATA", type: ORiN3BinaryConverter::DataType::NullableInt8Array },
    { name: "TAG_NIL_TEST_DATA", type: ORiN3BinaryConverter::DataType::NullableInt16Array },
    { name: "TAG_NIL_TEST_DATA", type: ORiN3BinaryConverter::DataType::NullableInt32Array },
    { name: "TAG_NIL_TEST_DATA", type: ORiN3BinaryConverter::DataType::NullableInt64Array },
    { name: "TAG_NIL_TEST_DATA", type: ORiN3BinaryConverter::DataType::NullableFloatArray },
    { name: "TAG_NIL_TEST_DATA", type: ORiN3BinaryConverter::DataType::NullableDoubleArray },
    { name: "TAG_NIL_TEST_DATA", type: ORiN3BinaryConverter::DataType::NullableDateTimeArray },
  ]

  TAG_NIL_TEST_DATA.each do |data|
    name = get_constant_name(data[:type], ORiN3BinaryConverter::DataType)
    define_method("test_tag_nil_#{name}") do
      $logger.info "* test_tag_nil_#{name} called."
      controller = create_or_get_controller(data[:name])
      exception = assert_raises(Grpc::Client::ORiN3::MessageClientError) do
        controller.set_tag("tag_name", nil, data[:type])
      end
      $logger.info "Exception message: #{exception.message}"
      assert_includes exception.message, "Value is nil."
    end
  end

  TAG_NIL_TEST_DATA2 = [
    { name: "TAG_NIL_TEST_DATA2", type: ORiN3BinaryConverter::DataType::BoolArray },
    { name: "TAG_NIL_TEST_DATA2", type: ORiN3BinaryConverter::DataType::UInt8Array },
    { name: "TAG_NIL_TEST_DATA2", type: ORiN3BinaryConverter::DataType::UInt16Array },
    { name: "TAG_NIL_TEST_DATA2", type: ORiN3BinaryConverter::DataType::UInt32Array },
    { name: "TAG_NIL_TEST_DATA2", type: ORiN3BinaryConverter::DataType::UInt64Array },
    { name: "TAG_NIL_TEST_DATA2", type: ORiN3BinaryConverter::DataType::Int8Array },
    { name: "TAG_NIL_TEST_DATA2", type: ORiN3BinaryConverter::DataType::Int16Array },
    { name: "TAG_NIL_TEST_DATA2", type: ORiN3BinaryConverter::DataType::Int32Array },
    { name: "TAG_NIL_TEST_DATA2", type: ORiN3BinaryConverter::DataType::Int64Array },
    { name: "TAG_NIL_TEST_DATA2", type: ORiN3BinaryConverter::DataType::FloatArray },
    { name: "TAG_NIL_TEST_DATA2", type: ORiN3BinaryConverter::DataType::DoubleArray },
    { name: "TAG_NIL_TEST_DATA2", type: ORiN3BinaryConverter::DataType::DateTimeArray },
  ]

  TAG_NIL_TEST_DATA2.each do |data|
    name = get_constant_name(data[:type], ORiN3BinaryConverter::DataType)
    define_method("test_tag_nil2_#{name}") do
      $logger.info "* test_tag_nil2_#{name} called."
      controller = create_or_get_controller(data[:name])
      exception = assert_raises(Grpc::Client::ORiN3::MessageClientError) do
        controller.set_tag("tag_name", [ nil ], data[:type])
      end
      $logger.info "Exception message: #{exception.message}"
      assert_includes exception.message, "Value is nil."
    end
  end

  # UINT8_MIN = 0
  # UINT8_MAX = 255
  # UINT16_MIN = 0
  # UINT16_MAX = 65535
  # UINT32_MIN = 0
  # UINT32_MAX = 4_294_967_295
  # UINT64_MIN = 0
  # UINT64_MAX = 18_446_744_073_709_551_615
  # INT8_MIN = -128
  # INT8_MAX = 127
  # INT16_MIN = -32768
  # INT16_MAX = 32767
  # INT32_MIN = -2_147_483_648
  # INT32_MAX = 2_147_483_647
  # INT64_MIN = -9_223_372_036_854_775_808
  # INT64_MAX = 9_223_372_036_854_775_807
  # FLOAT_MIN = -3.40282347E+38
  # FLOAT_MAX = 3.40282347E+38
  # DOUBLE_MIN = -1.7976931348623157e+308
  # DOUBLE_MAX = 1.7976931348623157e+308

  TAG_RANGE_TEST_DATA = [
    { name: "TAG_RANGE_TEST_DATA", type: ORiN3BinaryConverter::DataType::UInt8, values: [ UINT8_MIN - 1, UINT8_MAX + 1 ] },
    { name: "TAG_RANGE_TEST_DATA", type: ORiN3BinaryConverter::DataType::UInt16, values: [ UINT16_MIN - 1, UINT16_MAX + 1 ] },
    { name: "TAG_RANGE_TEST_DATA", type: ORiN3BinaryConverter::DataType::UInt32, values: [ UINT32_MIN - 1, UINT32_MAX + 1 ] },
    { name: "TAG_RANGE_TEST_DATA", type: ORiN3BinaryConverter::DataType::UInt64, values: [ UINT64_MIN - 1, UINT64_MAX + 1 ] },
    { name: "TAG_RANGE_TEST_DATA", type: ORiN3BinaryConverter::DataType::Int8, values: [ INT8_MIN - 1, INT8_MAX + 1 ] },
    { name: "TAG_RANGE_TEST_DATA", type: ORiN3BinaryConverter::DataType::Int16, values: [ INT16_MIN - 1, INT16_MAX + 1 ] },
    { name: "TAG_RANGE_TEST_DATA", type: ORiN3BinaryConverter::DataType::Int32, values: [ INT32_MIN - 1, INT32_MAX + 1 ] },
    { name: "TAG_RANGE_TEST_DATA", type: ORiN3BinaryConverter::DataType::Int64, values: [ INT64_MIN - 1, INT64_MAX + 1 ] },
    { name: "TAG_RANGE_TEST_DATA", type: ORiN3BinaryConverter::DataType::UInt8Array, values: [ [ UINT8_MIN - 1 ], [ UINT8_MAX + 1 ] ] },
    { name: "TAG_RANGE_TEST_DATA", type: ORiN3BinaryConverter::DataType::UInt16Array, values: [ [ UINT16_MIN - 1 ], [ UINT16_MAX + 1 ] ] },
    { name: "TAG_RANGE_TEST_DATA", type: ORiN3BinaryConverter::DataType::UInt32Array, values: [ [ UINT32_MIN - 1 ], [ UINT32_MAX + 1 ] ] },
    { name: "TAG_RANGE_TEST_DATA", type: ORiN3BinaryConverter::DataType::UInt64Array, values: [ [ UINT64_MIN - 1 ], [ UINT64_MAX + 1 ] ] },
    { name: "TAG_RANGE_TEST_DATA", type: ORiN3BinaryConverter::DataType::Int8Array, values: [ [ INT8_MIN - 1, INT8_MAX + 1 ] ] },
    { name: "TAG_RANGE_TEST_DATA", type: ORiN3BinaryConverter::DataType::Int16Array, values: [ [ INT16_MIN - 1, INT16_MAX + 1 ] ] },
    { name: "TAG_RANGE_TEST_DATA", type: ORiN3BinaryConverter::DataType::Int32Array, values: [ [ INT32_MIN - 1, INT32_MAX + 1 ] ] },
    { name: "TAG_RANGE_TEST_DATA", type: ORiN3BinaryConverter::DataType::Int64Array, values: [ [ INT64_MIN - 1, INT64_MAX + 1 ] ] },
    { name: "TAG_RANGE_TEST_DATA", type: ORiN3BinaryConverter::DataType::NullableUInt8Array, values: [ [ UINT8_MIN - 1 ], [ UINT8_MAX + 1 ] ] },
    { name: "TAG_RANGE_TEST_DATA", type: ORiN3BinaryConverter::DataType::NullableUInt16Array, values: [ [ UINT16_MIN - 1 ], [ UINT16_MAX + 1 ] ] },
    { name: "TAG_RANGE_TEST_DATA", type: ORiN3BinaryConverter::DataType::NullableUInt32Array, values: [ [ UINT32_MIN - 1 ], [ UINT32_MAX + 1 ] ] },
    { name: "TAG_RANGE_TEST_DATA", type: ORiN3BinaryConverter::DataType::NullableUInt64Array, values: [ [ UINT64_MIN - 1 ], [ UINT64_MAX + 1 ] ] },
    { name: "TAG_RANGE_TEST_DATA", type: ORiN3BinaryConverter::DataType::NullableInt8Array, values: [ [ INT8_MIN - 1, INT8_MAX + 1 ] ] },
    { name: "TAG_RANGE_TEST_DATA", type: ORiN3BinaryConverter::DataType::NullableInt16Array, values: [ [ INT16_MIN - 1, INT16_MAX + 1 ] ] },
    { name: "TAG_RANGE_TEST_DATA", type: ORiN3BinaryConverter::DataType::NullableInt32Array, values: [ [ INT32_MIN - 1, INT32_MAX + 1 ] ] },
    { name: "TAG_RANGE_TEST_DATA", type: ORiN3BinaryConverter::DataType::NullableInt64Array, values: [ [ INT64_MIN - 1, INT64_MAX + 1 ] ] },
  ]

  TAG_RANGE_TEST_DATA.each do |data|
    name = get_constant_name(data[:type], ORiN3BinaryConverter::DataType)
    define_method("test_tag_range_#{name}") do
      $logger.info "* test_tag_range_#{name} called."
      controller = create_or_get_controller(data[:name])
      data[:values].each do |value|
        exception = assert_raises(Grpc::Client::ORiN3::MessageClientError) do
          controller.set_tag("tag_name", value, data[:type])
        end
        $logger.info "Exception message: #{exception.message}"
        assert_includes exception.message, "out of range"
      end
    end
  end

  TAG_WITHOUT_TYPE_TEST_DATA = [
    { name: "TAG_WITHOUT_TYPE_TEST_DATA", type: "Nil", value: { nil: nil } },
    { name: "TAG_WITHOUT_TYPE_TEST_DATA", type: "Bool", value: { true: false, false: true } },
    { name: "TAG_WITHOUT_TYPE_TEST_DATA", type: "Integer", value: { min: -9_223_372_036_854_775_808, common: 0, max: 9_223_372_036_854_775_807 } },
    { name: "TAG_WITHOUT_TYPE_TEST_DATA", type: "String", value: { common: "あいうえお𩸽abc" } },
    { name: "TAG_WITHOUT_TYPE_TEST_DATA", type: "BoolArray", value: { common: [ false, true ] } },
    { name: "TAG_WITHOUT_TYPE_TEST_DATA", type: "NullableBoolArray", value: { common: [ false, nil, true ] } },
    { name: "TAG_WITHOUT_TYPE_TEST_DATA", type: "IntegerArray", value: { common: [ -9_223_372_036_854_775_808, 0, 9_223_372_036_854_775_807 ] } },
    { name: "TAG_WITHOUT_TYPE_TEST_DATA", type: "NullableIntegerArray", value: { common: [ -9_223_372_036_854_775_808, 0, nil, 9_223_372_036_854_775_807 ] } },
  ]

  TAG_WITHOUT_TYPE_TEST_DATA.each do |data|
    name = data[:type]
    define_method("test_tag_without_type_#{name}") do
      $logger.info "* test_tag_without_type_#{name} called."
      controller = create_or_get_controller(data[:name])
      data[:value].each do |key, value|
        tag_name ="#{name}_#{key}"
        controller.set_tag(tag_name, value)
        tag = controller.get_tag(tag_name)
        $logger.info "name: #{tag_name}, data type: #{tag.class.name}, value: #{tag}"
        if value.nil?
          assert_nil tag
        else
          assert_equal value, tag
        end
      end
    end
  end

  def test_tag_management
    $logger.info "* test_tag_management called."
    controller = create_or_get_controller("test_tag_management")

    keys = controller.get_tag_keys
    assert_equal 0, keys.length

    controller.set_tag("hoge", 1)
    keys = controller.get_tag_keys
    assert_equal 1, keys.length
    assert_equal "hoge", keys[0]

    controller.set_tag("fuga", 2)
    keys = controller.get_tag_keys
    assert_equal 2, keys.length
    assert_equal true, keys.include?("hoge")
    assert_equal true, keys.include?("fuga")
    assert_equal 1, controller.get_tag("hoge")
    assert_equal 2, controller.get_tag("fuga")

    controller.remove_tag("hoge")
    keys = controller.get_tag_keys
    assert_equal 1, keys.length
    assert_equal true, keys.include?("fuga")
    assert_equal 2, controller.get_tag("fuga")

    controller.set_tag("fuga", 10)
    keys = controller.get_tag_keys
    assert_equal 1, keys.length
    assert_equal true, keys.include?("fuga")
    assert_equal 10, controller.get_tag("fuga")

    controller.set_tag("fuga", "abc")
    keys = controller.get_tag_keys
    assert_equal 1, keys.length
    assert_equal true, keys.include?("fuga")
    assert_equal "abc", controller.get_tag("fuga")

    controller.remove_tag("fuga")
    keys = controller.get_tag_keys
    assert_equal 0, keys.length
  end

  VARIABLE_TEST_DATA = [
    { name: "ORIN3_BOOL", type: :ORIN3_BOOL, value: [ true, false, true ] },
    { name: "ORIN3_UINT8", type: :ORIN3_UINT8, value: [ UINT8_MIN, 1, UINT8_MAX ] },
    { name: "ORIN3_UINT16", type: :ORIN3_UINT16, value: [ UINT16_MIN, 1, UINT16_MAX ] },
    { name: "ORIN3_UINT32", type: :ORIN3_UINT32, value: [ UINT32_MIN, 1, UINT32_MAX ] },
    { name: "ORIN3_UINT64", type: :ORIN3_UINT64, value: [ UINT64_MIN, 1, UINT64_MAX ] },
    { name: "ORIN3_INT8", type: :ORIN3_INT8, value: [ INT8_MIN, 1, INT8_MAX ] },
    { name: "ORIN3_INT16", type: :ORIN3_INT16, value: [ INT16_MIN, 1, INT16_MAX ] },
    { name: "ORIN3_INT32", type: :ORIN3_INT32, value: [ INT32_MIN, 1, INT32_MAX ] },
    { name: "ORIN3_INT64", type: :ORIN3_INT64, value: [ INT64_MIN, 1, INT64_MAX ] },
    { name: "ORIN3_FLOAT", type: :ORIN3_FLOAT, value: [ 0.0, 1.0 ] },
    { name: "ORIN3_DOUBLE", type: :ORIN3_DOUBLE, value: [ DOUBLE_MIN, 1.0, DOUBLE_MAX ] },
    { name: "ORIN3_DATETIME", type: :ORIN3_DATETIME, value: [ Time.utc(1, 1, 1, 0, 0, 0), Time.utc(9999, 12, 31, 23, 59, 59) ] },
    { name: "ORIN3_STRING", type: :ORIN3_STRING, value: [ "123456", nil, "abc𩸽123" ] },

    { name: "ORIN3_NULLABLE_BOOL", type: :ORIN3_NULLABLE_BOOL, value: [ nil, false, true ] },
    { name: "ORIN3_NULLABLE_UINT8", type: :ORIN3_NULLABLE_UINT8, value: [ UINT8_MIN, 1, nil, UINT8_MAX ] },
    { name: "ORIN3_NULLABLE_UINT16", type: :ORIN3_NULLABLE_UINT16, value: [ UINT16_MIN, 1, nil, UINT16_MAX ] },
    { name: "ORIN3_NULLABLE_UINT32", type: :ORIN3_NULLABLE_UINT32, value: [ UINT32_MIN, 1, nil, UINT32_MAX ] },
    { name: "ORIN3_NULLABLE_UINT64", type: :ORIN3_NULLABLE_UINT64, value: [ UINT64_MIN, 1, nil, UINT64_MAX ] },
    { name: "ORIN3_NULLABLE_INT8", type: :ORIN3_NULLABLE_INT8, value: [ INT8_MIN, 1, nil, INT8_MAX ] },
    { name: "ORIN3_NULLABLE_INT16", type: :ORIN3_NULLABLE_INT16, value: [ INT16_MIN, 1, nil, INT16_MAX ] },
    { name: "ORIN3_NULLABLE_INT32", type: :ORIN3_NULLABLE_INT32, value: [ INT32_MIN, 1, nil, INT32_MAX ] },
    { name: "ORIN3_NULLABLE_INT64", type: :ORIN3_NULLABLE_INT64, value: [ INT64_MIN, 1, nil, INT64_MAX ] },
    { name: "ORIN3_NULLABLE_FLOAT", type: :ORIN3_NULLABLE_FLOAT, value: [ 0.0, nil, 1.0 ] },
    { name: "ORIN3_NULLABLE_DOUBLE", type: :ORIN3_NULLABLE_DOUBLE, value: [ DOUBLE_MIN, 1.0, nil, DOUBLE_MAX ] },
    { name: "ORIN3_NULLABLE_DATETIME", type: :ORIN3_NULLABLE_DATETIME, value: [ Time.utc(1, 1, 1, 0, 0, 0), nil, Time.utc(9999, 12, 31, 23, 59, 59) ] },

    { name: "ORIN3_BOOL_ARRAY", type: :ORIN3_BOOL_ARRAY, value: [[ true, false, true ], [ false, true, false ]] },
    { name: "ORIN3_UINT8_ARRAY", type: :ORIN3_UINT8_ARRAY, value: [[ UINT8_MIN, 1, UINT8_MAX ], [ UINT8_MAX, UINT8_MIN, 1 ]] },
    { name: "ORIN3_UINT16_ARRAY", type: :ORIN3_UINT16_ARRAY, value: [[ UINT16_MIN, 1, UINT16_MAX ], [ UINT16_MAX, UINT16_MIN, 1 ]] },
    { name: "ORIN3_UINT32_ARRAY", type: :ORIN3_UINT32_ARRAY, value: [[ UINT32_MIN, 1, UINT32_MAX ], [ UINT32_MAX, UINT32_MIN, 1 ]] },
    { name: "ORIN3_UINT64_ARRAY", type: :ORIN3_UINT64_ARRAY, value: [[ UINT64_MIN, 1, UINT64_MAX ], [ UINT64_MAX, UINT64_MIN, 1 ]] },
    { name: "ORIN3_INT8_ARRAY", type: :ORIN3_INT8_ARRAY, value: [[ INT8_MIN, 1, INT8_MAX ], [ INT8_MAX, INT8_MIN, 1 ]] },
    { name: "ORIN3_INT16_ARRAY", type: :ORIN3_INT16_ARRAY, value: [[ INT16_MIN, 1, INT16_MAX ], [ INT16_MAX, INT16_MIN, 1 ]] },
    { name: "ORIN3_INT32_ARRAY", type: :ORIN3_INT32_ARRAY, value: [[ INT32_MIN, 1, INT32_MAX ], [ INT32_MAX, INT32_MIN, 1 ]] },
    { name: "ORIN3_INT64_ARRAY", type: :ORIN3_INT64_ARRAY, value: [[ INT64_MIN, 1, INT64_MAX ], [ INT64_MAX, INT64_MIN, 1 ]] },
    { name: "ORIN3_FLOAT_ARRAY", type: :ORIN3_FLOAT_ARRAY, value: [[ 0.0, 1.0 ], [ 2.0, 3.0 ]] },
    { name: "ORIN3_DOUBLE_ARRAY", type: :ORIN3_DOUBLE_ARRAY, value: [[ DOUBLE_MIN, 1.0, DOUBLE_MAX ], [ DOUBLE_MAX, DOUBLE_MIN, 1.0 ]] },
    { name: "ORIN3_DATETIME_ARRAY", type: :ORIN3_DATETIME_ARRAY, value: [[ Time.utc(1, 1, 1, 0, 0, 0), Time.utc(9999, 12, 31, 23, 59, 59) ], [ Time.utc(9999, 12, 31, 23, 59, 59), Time.utc(1, 1, 1, 0, 0, 0) ]] },
    { name: "ORIN3_STRING_ARRAY", type: :ORIN3_STRING_ARRAY, value: [[ "123456", nil, "abc𩸽123" ], [ "abc𩸽123", "123456", nil ]] },

    { name: "ORIN3_NULLABLE_BOOL_ARRAY", type: :ORIN3_NULLABLE_BOOL_ARRAY, value: [[ true, false, true ], [ nil, nil, nil ], [ false, nil, false ]] },
    { name: "ORIN3_NULLABLE_UINT8_ARRAY", type: :ORIN3_NULLABLE_UINT8_ARRAY, value: [[ UINT8_MIN, 1, UINT8_MAX ], [ nil, nil, nil ], [ UINT8_MAX, UINT8_MIN, nil ]] },
    { name: "ORIN3_NULLABLE_UINT16_ARRAY", type: :ORIN3_NULLABLE_UINT16_ARRAY, value: [[ UINT16_MIN, 1, UINT16_MAX ], [ nil, nil, nil ], [ UINT16_MAX, UINT16_MIN, nil ]] },
    { name: "ORIN3_NULLABLE_UINT32_ARRAY", type: :ORIN3_NULLABLE_UINT32_ARRAY, value: [[ UINT32_MIN, 1, UINT32_MAX ], [ nil, nil, nil ], [ UINT32_MAX, UINT32_MIN, nil ]] },
    { name: "ORIN3_NULLABLE_UINT64_ARRAY", type: :ORIN3_NULLABLE_UINT64_ARRAY, value: [[ UINT64_MIN, 1, UINT64_MAX ], [ nil, nil, nil ], [ UINT64_MAX, UINT64_MIN, nil ]] },
    { name: "ORIN3_NULLABLE_INT8_ARRAY", type: :ORIN3_NULLABLE_INT8_ARRAY, value: [[ INT8_MIN, 1, INT8_MAX ], [ nil, nil, nil] , [ INT8_MAX, INT8_MIN, nil ]] },
    { name: "ORIN3_NULLABLE_INT16_ARRAY", type: :ORIN3_NULLABLE_INT16_ARRAY, value: [[ INT16_MIN, 1, INT16_MAX ], [ nil, nil, nil ], [ INT16_MAX, INT16_MIN, nil ]] },
    { name: "ORIN3_NULLABLE_INT32_ARRAY", type: :ORIN3_NULLABLE_INT32_ARRAY, value: [[ INT32_MIN, 1, INT32_MAX ], [ nil, nil, nil ], [ INT32_MAX, INT32_MIN, nil ]] },
    { name: "ORIN3_NULLABLE_INT64_ARRAY", type: :ORIN3_NULLABLE_INT64_ARRAY, value: [[ INT64_MIN, 1, INT64_MAX ], [ nil, nil, nil ], [ INT64_MAX, INT64_MIN, nil ]] },
    { name: "ORIN3_NULLABLE_FLOAT_ARRAY", type: :ORIN3_NULLABLE_FLOAT_ARRAY, value: [[ 0.0, 1.0 ], [ nil, nil ], [ 2.0, nil ]] },
    { name: "ORIN3_NULLABLE_DOUBLE_ARRAY", type: :ORIN3_NULLABLE_DOUBLE_ARRAY, value: [[ DOUBLE_MIN, 1.0, DOUBLE_MAX ], [ nil, nil, nil ], [ DOUBLE_MAX, DOUBLE_MIN, nil ]] },
    { name: "ORIN3_NULLABLE_DATETIME_ARRAY", type: :ORIN3_NULLABLE_DATETIME_ARRAY, value: [[ Time.utc(1, 1, 1, 0, 0, 0), Time.utc(9999, 12, 31, 23, 59, 59) ], [ nil, nil ], [ Time.utc(9999, 12, 31, 23, 59, 59), nil ]] },
  ]

  VARIABLE_TEST_DATA.each do |data|
    name = data[:name]
    define_method("test_variable_#{name}") do
      $logger.info "* test_variable_#{name} called."
      parent = create_or_get_controller("test_variable")
      if two_dimensional_array?(data[:value])
        length = data[:value][0].length
        option = {}
        option["Element Count"] = length
        variable = create_or_get_variable(parent, name, option, data[:type])
      else
        variable = create_or_get_variable(parent, name, nil, data[:type])
      end
      data[:value].each do |it|
        variable.set_value(it)
        if it.nil?
          assert_nil variable.get_value
        else
          assert_equal it, variable.get_value
        end
      end
    end
  end

  def two_dimensional_array?(target)
    target.is_a?(Array) && target.all? { |e| e.is_a?(Array) }
  end
end