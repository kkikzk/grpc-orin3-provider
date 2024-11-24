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

module ORiN3
  include Grpc::Client::ORiN3
  include Grpc::Client::ORiN3::Provider
end

class ORiN3ProviderTest < Minitest::Test
  include Minitest::Hooks
  
  def before_all
    puts "......................."
    $logger.info "* before_all called."
    @port = 50051
    @channel = GRPC::Core::Channel.new("localhost:#{@port}", nil, :this_channel_is_insecure)
    @server_thread = Thread.new { run_mock_server(@port) }
    sleep(1) # waiting for server
    $logger.info "* before_all finished."
  end
  
  def after_all
    puts "......................."
    $logger.info "* after_all called."
    Thread.kill(@server_thread)
    $logger.info "* after_all finished."
  end
  
  def setup
    puts "......................."
    $logger.info "* setup called."
  end
  
  def teardown
    $logger.info "* teardown called."
  end

  def run_mock_server(port)
    #server = GRPC::RpcServer.new
    #server.add_http2_port("localhost:#{port}", :this_port_is_insecure)
    #@base_object_service_mock_server = BaseObjectServiceMockServer.new
    #server.handle(@base_object_service_mock_server)
    #server.run_till_terminated
  end

  def tag_test(root, data, type)
    $logger.info "type=#{type}, data=#{data.nil? ? 'nil' : data}"
    # root.set_tag("tag", data)
    # tag = root.get_tag("tag")
    # $logger.info "data type #{tag.class.name}"
    # if data.nil?
    #   assert_nil tag
    # else
    #   assert_equal data, tag
    # end
    # assert_equal 1, root.get_tag_keys.length
    # root.remove_tag("tag")
    # assert_equal 0, root.get_tag_keys.length

    root.set_tag("tag", data, type)
    tag = root.get_tag("tag")
    $logger.info "data type #{tag.class.name}"
    if data.nil?
      assert_nil tag
    else
      assert_equal data, tag
    end
    assert_equal 1, root.get_tag_keys.length
    root.remove_tag("tag")
    assert_equal 0, root.get_tag_keys.length
  end

  def tag_test_without_type(root, data)
    $logger.info "data=#{data.nil? ? 'nil' : data}"
    root.set_tag("tag", data)
    tag = root.get_tag("tag")
    $logger.info "data type #{tag.class.name}"
    if data.nil?
      assert_nil tag
    else
      assert_equal data, tag
    end
    assert_equal 1, root.get_tag_keys.length
    root.remove_tag("tag")
    assert_equal 0, root.get_tag_keys.length
  end

  def test_
    $logger.info "* test_ called."

    # act
    id = "643D12C8-DCFC-476C-AA15-E8CA004F48E8"
    version = "1.0.84-beta.8"
    channel = GRPC::Core::Channel.new("localhost:7103", nil, :this_channel_is_insecure)
    remote_engine = ORiN3::RemoteEngine.new(channel)
    result = remote_engine.wakeup_provider(id, version, "0.0.0.0", 0)

    $logger.info "result.idの型: #{result.id.class}"
    $logger.info "result.idのサイズ: #{result.id.bytesize} バイト"
    $logger.info "result.idの内容 (16進数): #{result.id.unpack('H*').first}"
    # ASCIIエンコードされた文字列をデコード
    guid = result.id.force_encoding('ASCII-8BIT').force_encoding('UTF-8')
    $logger.info "GUID文字列: #{guid}"

    $logger.info "Uri: #{result.provider_information.endpoints[0].uri}"
    $logger.info "[#{result.provider_information.endpoints[0].index}] IP address: #{result.provider_information.endpoints[0].ip_address}:#{result.provider_information.endpoints[0].port}"

    uri = URI.parse(result.provider_information.endpoints[0].uri)
    provider_channerl = GRPC::Core::Channel.new("#{uri.host}:#{uri.port}", nil, :this_channel_is_insecure)
    root = ORiN3::ORiN3RootObject.attach(provider_channerl)

    $logger.info "Root.name: #{root.name}"
    $logger.info "Root.type_name: #{root.type_name}"
    $logger.info "Root.option: #{root.option}"
    $logger.info "Root.created_datetime: #{root.created_datetime}"
    $logger.info "Root.orin3_object_type: #{root.orin3_object_type}"
    $logger.info "Root.id: #{root.id}"

    info = root.get_information
    #$logger.info "Info.config: #{info.orin3_provider_config}"
    $logger.info "Info.connection_count: #{info.connection_count}"

    tag_test(root, nil, ORiN3BinaryConverter::DataType::Nil)
    tag_test(root, true, ORiN3BinaryConverter::DataType::Bool)
    tag_test(root, false, ORiN3BinaryConverter::DataType::Bool)
    tag_test(root, [ true, false ], ORiN3BinaryConverter::DataType::BoolArray)
    tag_test(root, [ true, nil, false ], ORiN3BinaryConverter::DataType::NullableBoolArray)

    tag_test(root, 0, ORiN3BinaryConverter::DataType::UInt8)
    tag_test(root, 255, ORiN3BinaryConverter::DataType::UInt8)
    tag_test(root, [ 0, 255 ], ORiN3BinaryConverter::DataType::UInt8Array)
    tag_test(root, [ 0, nil, 255 ], ORiN3BinaryConverter::DataType::NullableUInt8Array)
    tag_test(root, -128, ORiN3BinaryConverter::DataType::Int8)
    tag_test(root, 127, ORiN3BinaryConverter::DataType::Int8)
    tag_test(root, [ -128, 0, 127 ], ORiN3BinaryConverter::DataType::Int8Array)
    tag_test(root, [ -128, 0, nil, 127 ], ORiN3BinaryConverter::DataType::NullableInt8Array)

    tag_test(root, 0, ORiN3BinaryConverter::DataType::UInt16)
    tag_test(root, 65535, ORiN3BinaryConverter::DataType::UInt16)
    tag_test(root, [ 0, 65535 ], ORiN3BinaryConverter::DataType::UInt16Array)
    tag_test(root, [ 0, nil, 65535 ], ORiN3BinaryConverter::DataType::NullableUInt16Array)
    tag_test(root, -32768, ORiN3BinaryConverter::DataType::Int16)
    tag_test(root, 32767, ORiN3BinaryConverter::DataType::Int16)
    tag_test(root, [ -32768, 0, 32767 ], ORiN3BinaryConverter::DataType::Int16Array)
    tag_test(root, [ -32768, 0, nil, 32767 ], ORiN3BinaryConverter::DataType::NullableInt16Array)

    tag_test(root, 0, ORiN3BinaryConverter::DataType::UInt32)
    tag_test(root, 4_294_967_295, ORiN3BinaryConverter::DataType::UInt32)
    tag_test(root, [ 0, 4_294_967_295 ], ORiN3BinaryConverter::DataType::UInt32Array)
    tag_test(root, [ 0, nil, 4_294_967_295 ], ORiN3BinaryConverter::DataType::NullableUInt32Array)
    tag_test(root, -2_147_483_648, ORiN3BinaryConverter::DataType::Int32)
    tag_test(root, 2_147_483_647, ORiN3BinaryConverter::DataType::Int32)
    tag_test(root, [ -2_147_483_648, 0, 2_147_483_647 ], ORiN3BinaryConverter::DataType::Int32Array)
    tag_test(root, [ -2_147_483_648, 0, nil, 2_147_483_647 ], ORiN3BinaryConverter::DataType::NullableInt32Array)

    tag_test(root, 0, ORiN3BinaryConverter::DataType::UInt64)
    tag_test(root, 18_446_744_073_709_551_615, ORiN3BinaryConverter::DataType::UInt64)
    tag_test(root, [ 0, 18_446_744_073_709_551_615 ], ORiN3BinaryConverter::DataType::UInt64Array)
    tag_test(root, [ 0, nil, 18_446_744_073_709_551_615 ], ORiN3BinaryConverter::DataType::NullableUInt64Array)
    tag_test(root, -9_223_372_036_854_775_808, ORiN3BinaryConverter::DataType::Int64)
    tag_test(root, 9_223_372_036_854_775_807, ORiN3BinaryConverter::DataType::Int64)
    tag_test(root, [ -9_223_372_036_854_775_808, 0, 9_223_372_036_854_775_807 ], ORiN3BinaryConverter::DataType::Int64Array)
    tag_test(root, [ -9_223_372_036_854_775_808, 0, nil, 9_223_372_036_854_775_807 ], ORiN3BinaryConverter::DataType::NullableInt64Array)

    tag_test(root, 0.0, ORiN3BinaryConverter::DataType::Float)
    tag_test(root, 1.0, ORiN3BinaryConverter::DataType::Float)
    tag_test(root, [ 0.0, 1.0 ], ORiN3BinaryConverter::DataType::FloatArray)
    tag_test(root, [ 0.0, nil, 1.0 ], ORiN3BinaryConverter::DataType::NullableFloatArray)

    tag_test(root, 0.0, ORiN3BinaryConverter::DataType::Double)
    tag_test(root, Float::MAX, ORiN3BinaryConverter::DataType::Double)
    tag_test(root, [ Float::MIN, 0.0, Float::MAX, Float::INFINITY, -Float::INFINITY ], ORiN3BinaryConverter::DataType::DoubleArray)
    tag_test(root, [ Float::MIN, nil, 0.0, Float::MAX, Float::INFINITY, -Float::INFINITY ], ORiN3BinaryConverter::DataType::NullableDoubleArray)

    # todo String, DateTime

    tag_test_without_type(root, nil)
    tag_test_without_type(root, true)
    tag_test_without_type(root, false)
    tag_test_without_type(root, [ true, false ])
    tag_test_without_type(root, [ true, nil, false ])
    tag_test_without_type(root, 0)
    tag_test_without_type(root, 9_223_372_036_854_775_807)
    tag_test_without_type(root, -9_223_372_036_854_775_808)
    tag_test_without_type(root, [ 9_223_372_036_854_775_807, -9_223_372_036_854_775_808 ])
    tag_test_without_type(root, [ 9_223_372_036_854_775_807, nil, -9_223_372_036_854_775_808 ])
    tag_test_without_type(root, "あいうえお")


    root.set_tag("Bool1", true, ORiN3BinaryConverter::DataType::Bool)
    root.set_tag("Bool2", false, ORiN3BinaryConverter::DataType::Bool)
    root.set_tag("BoolArray", [ true, false, true ], ORiN3BinaryConverter::DataType::BoolArray)
    root.set_tag("NullableBoolArray", [ true, nil, false ], ORiN3BinaryConverter::DataType::NullableBoolArray)
    root.set_tag("String", "aaaあいうえお", ORiN3BinaryConverter::DataType::String)
    #root.set_tag("StringArray", [ "aa", nil, "bb" ], ORiN3BinaryConverter::DataType::StringArray)
    root.set_tag("StringArray", [ "aa", "bb" ], ORiN3BinaryConverter::DataType::StringArray)

    dt = DateTime.parse('2024-11-24T08:16:58.1544812Z')
    root.set_tag("DateTime", dt, ORiN3BinaryConverter::DataType::DateTime)
    root.set_tag("Int8", 22, ORiN3BinaryConverter::DataType::Int8)
    root.set_tag("Int8Array", [ 22, 23, 24 ], ORiN3BinaryConverter::DataType::Int8Array)
    root.set_tag("NullableInt8Array", [ 22, nil, 24 ], ORiN3BinaryConverter::DataType::NullableInt8Array)
    root.set_tag("UInt8", 23, ORiN3BinaryConverter::DataType::UInt8)
    root.set_tag("UInt8Array", [ 23, 24, 25 ], ORiN3BinaryConverter::DataType::UInt8Array)
    root.set_tag("NullableUInt8Array", [ 23, nil, 25 ], ORiN3BinaryConverter::DataType::NullableUInt8Array)
    root.set_tag("Int16", 24, ORiN3BinaryConverter::DataType::Int16)
    root.set_tag("Int16Array", [ 24, 25, 26 ], ORiN3BinaryConverter::DataType::Int16Array)
    root.set_tag("NullableInt16Array", [ 24, nil, 26 ], ORiN3BinaryConverter::DataType::NullableInt16Array)
    root.set_tag("UInt16", 25, ORiN3BinaryConverter::DataType::UInt16)
    root.set_tag("UInt16Array", [ 25, 26, 27 ], ORiN3BinaryConverter::DataType::UInt16Array)
    root.set_tag("NullableUInt16Array", [ 25, nil, 27 ], ORiN3BinaryConverter::DataType::NullableUInt16Array)
    root.set_tag("Int32", 26, ORiN3BinaryConverter::DataType::Int32)
    root.set_tag("Int32Array", [ 26, 27, 28 ], ORiN3BinaryConverter::DataType::Int32Array)
    root.set_tag("NullableInt32Array", [ 26, nil, 28 ], ORiN3BinaryConverter::DataType::NullableInt32Array)
    root.set_tag("UInt32", 27, ORiN3BinaryConverter::DataType::UInt32)
    root.set_tag("UInt32Array", [ 27, 28, 29 ], ORiN3BinaryConverter::DataType::UInt32Array)
    root.set_tag("NullableUInt32Array", [ 27, nil, 29 ], ORiN3BinaryConverter::DataType::NullableUInt32Array)
    root.set_tag("Int64", 28, ORiN3BinaryConverter::DataType::Int64)
    root.set_tag("Int64Array", [ 28, 29, 30 ], ORiN3BinaryConverter::DataType::Int64Array)
    root.set_tag("NullableInt64Array", [ 28, nil, 30 ], ORiN3BinaryConverter::DataType::NullableInt64Array)
    root.set_tag("UInt64", 29, ORiN3BinaryConverter::DataType::UInt64)
    root.set_tag("UInt64Array", [ 29, 30, 31 ], ORiN3BinaryConverter::DataType::UInt64Array)
    root.set_tag("NullableUInt64Array", [ 29, nil, 31 ], ORiN3BinaryConverter::DataType::NullableUInt64Array)
    root.set_tag("Float", 30, ORiN3BinaryConverter::DataType::Float)
    root.set_tag("FloatArray", [ 30, 31, 32 ], ORiN3BinaryConverter::DataType::FloatArray)
    root.set_tag("NullableFloatArray", [ 30, nil, 32 ], ORiN3BinaryConverter::DataType::NullableFloatArray)
    root.set_tag("Double", 30, ORiN3BinaryConverter::DataType::Double)
    root.set_tag("DoubleArray", [ 31, 32, 33 ], ORiN3BinaryConverter::DataType::DoubleArray)
    root.set_tag("NullableDoubleArray", [ 31, nil, 33 ], ORiN3BinaryConverter::DataType::NullableDoubleArray)

    root.set_tag("Int32", 23)
    root.set_tag("Int32[]", [ 23, 12 ])
    root.set_tag("NullableInt32[]", [ 23, 12, nil, 4 ])
    root.set_tag("fuga", 100000000)
    tag = root.get_tag("Int32")
    $logger.info "Tag: #{tag}[#{tag.class.name}]"

    #root.remove_tag("hoge")

    tag_keys = root.get_tag_keys()
    tag_keys.each_with_index do |key, index|
      $logger.info "Tag key: [#{index}] #{key} = #{root.get_tag(key) || "nil"}"
    end

    $logger.info "Status: #{root.get_status}"

    #root.shutdown

    #binary_guid = [guid.delete('-')].pack('H*')
    #remote_engine.terminate_provider(result.id)
  end
end