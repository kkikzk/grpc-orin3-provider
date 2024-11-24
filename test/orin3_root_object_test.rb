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

  def test_
    $logger.info "* test_ called."

    # act
    id = "643D12C8-DCFC-476C-AA15-E8CA004F48E8"
    version = "1.0.84-beta.8"
    channel = GRPC::Core::Channel.new("localhost:7103", nil, :this_channel_is_insecure)
    remote_engine = ORiN3::RemoteEngine.new(channel)
    result = remote_engine.wakeup_provider(id, version, "127.0.0.1", 0)

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

    root.shutdown

    #binary_guid = [guid.delete('-')].pack('H*')
    #remote_engine.terminate_provider(result.id)
  end
end