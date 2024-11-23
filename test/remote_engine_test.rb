require 'logger'
require 'minitest/autorun'
require 'minitest/hooks/default'
require 'minitest/autorun'
require_relative '../lib/grpc/orin3/provider'

$logger = Logger.new(STDOUT)
$logger.formatter = proc do |severity, datetime, progname, msg|
  "[#{datetime}] #{severity}: #{msg}\n"
end

module ORiN3
  include Grpc::ORiN3::Client
  include Message::ORiN3::RemoteEngine::V1::AutoGenerated
end

class RemoteEngineMockServer < ORiN3::RemoteEngineService::Service
    attr_accessor :response_values
  
    def initialize
      @response_values = {
        result_code: 0,
        detail: "",
        status: 0,
        instance_id: "",
        host: "",
        addresses: [ "" ],
        version: "1.0.0",
        os_platform: :OSX,
        os_description: "",
        running_provider_count: 0,
        id: "\x01\x02\x03\x04",
      }
    end
  
    def get_remote_engine_status(request, _call)
      $logger.info "* get_remote_engine_status called."
      common = ORiN3::CommonResponse.new(result_code: response_values[:result_code], detail: response_values[:detail])
      return ORiN3::GetRemoteEngineStatusResponse.new(
        common: common,
        status: response_values[:status],
        instance_id: response_values[:instance_id],
        host: response_values[:host],
        addresses: response_values[:addresses],
        version: response_values[:version],
        os_platform: response_values[:os_platform],
        os_description: response_values[:os_description],
        running_provider_count: response_values[:running_provider_count],
      )
    end

    def wakeup_provider(request, _call)
      $logger.info "* wakeup_provider called."
      common = ORiN3::CommonResponse.new(result_code: response_values[:result_code], detail: response_values[:detail])
      return ORiN3::WakeupProviderResponse.new(common: common)
    end

    def terminate_provider(request, _call)
      $logger.info "* terminate_provider called."

      # assert
      $logger.info "Id: #{request.id}"
      if (response_values[:id] != request.id)
        raise StandardError.new("Error #{response_values[:id]} #{request.id}")
      elsif (request.id == "\x01\x02\x03\x04\x05")
        raise StandardError.new("Error #{response_values[:id]} #{request.id}")
      end

      common = ORiN3::CommonResponse.new(result_code: response_values[:result_code], detail: response_values[:detail])
      return ORiN3::TerminateProviderResponse.new(common: common)
    end
  end

class RemoteEngineTest < Minitest::Test
  include Minitest::Hooks

  def before_all
    puts "......................."
    $logger.info "* before_all called."
    @port = 50052
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
    server = GRPC::RpcServer.new
    server.add_http2_port("localhost:#{port}", :this_port_is_insecure)
    @remote_engine_mock_server = RemoteEngineMockServer.new
    server.handle(@remote_engine_mock_server)
    server.run_till_terminated
  end

  def test_get_status
    # arrange
    $logger.info "* test_shutdown called."
    @remote_engine_mock_server.response_values[:result_code] = :SUCCEEDED
    @remote_engine_mock_server.response_values[:detail] = "hoge"
    @remote_engine_mock_server.response_values[:status] = 1
    @remote_engine_mock_server.response_values[:instance_id] = "fuga"
    @remote_engine_mock_server.response_values[:host] = "hogefuga"
    @remote_engine_mock_server.response_values[:addresses] = [ "127.0.0.1" ]
    @remote_engine_mock_server.response_values[:version] = "1.2.3"
    @remote_engine_mock_server.response_values[:os_platform] = :WINDOWS
    @remote_engine_mock_server.response_values[:os_description] = "os_description"
    @remote_engine_mock_server.response_values[:running_provider_count] = 123

    # act
    sut = ORiN3::RemoteEngine.new(@channel)
    actual = sut.get_status()

    # assert
    $logger.info "Result code: #{actual.result_code}"
    assert_equal :SUCCEEDED, actual.result_code
    $logger.info "Status: #{actual.status}"
    assert_equal 1, actual.status
    $logger.info "Instance id: #{actual.instance_id}"
    assert_equal "fuga", actual.instance_id
    $logger.info "Host: #{actual.host}"
    assert_equal "hogefuga", actual.host
    $logger.info "Address: #{actual.addresses}"
    assert_equal [ "127.0.0.1" ], actual.addresses
    $logger.info "Version: #{actual.version}"
    assert_equal "1.2.3", actual.version
    $logger.info "OS Platform: #{actual.os_platform}"
    assert_equal :WINDOWS, actual.os_platform
    $logger.info "OS Description: #{actual.os_description}"
    assert_equal "os_description", actual.os_description
    $logger.info "Running provider count: #{actual.running_provider_count}"
    assert_equal 123, actual.running_provider_count
  end

  def test_wakeup_provider
    # arrange
    $logger.info "* test_wakeup_provider called."

    id = "643D12C8-DCFC-476C-AA15-E8CA004F48E8"
    #id = [uuid_str.delete('-')].pack('H*').force_encoding('UTF-8')
    #id = [uuid_str].pack('H*').force_encoding('UTF-8')
    #id = [uuid_str.delete('-')].pack('H*')

    # act
    sut = ORiN3::RemoteEngine.new(@channel)
    actual = sut.wakeup_provider(id, "1.0.84-beta.8", "127.0.0.1", 0)

    $logger.info actual.id
    $logger.info actual.id.inspect
    actual.provider_information.endpoints.map do |endpoint|
      $logger.info "[#{endpoint.index}] IP address: #{endpoint.ip_address}:#{endpoint.port}"
      $logger.info "[#{endpoint.index}] Uri: #{endpoint.uri}"
      $logger.info "[#{endpoint.index}] Protocol type: #{endpoint.protocol_type}"
    end
  end

  def test_terminate_provider
    # arrange
    $logger.info "* test_terminate_provider called."
    @remote_engine_mock_server.response_values[:result_code] = :SUCCEEDED
    @remote_engine_mock_server.response_values[:detail] = "hoge"
    @remote_engine_mock_server.response_values[:id] = "\x01\x02\x03\x04"

    # act
    sut = ORiN3::RemoteEngine.new(@channel)
    sut.terminate_provider("\x01\x02\x03\x04")
  end

  def test_terminate_provider2
    # arrange
    $logger.info "* test_terminate_provider2 called."
    @remote_engine_mock_server.response_values[:result_code] = :INVALID_OPTION
    @remote_engine_mock_server.response_values[:detail] = "hoge"
    @remote_engine_mock_server.response_values[:id] = "\x01\x02\x03\x04"

    # act
    sut = ORiN3::RemoteEngine.new(@channel)
    begin
      sut.terminate_provider("\x01\x02\x03\x04")
    rescue ORiN3::MessageClientError => e
      # assert
      $logger.info "Result code: #{e.result_code}"
      assert_equal :INVALID_OPTION, e.result_code
      $logger.info "Detail: #{e.detail}"
      assert_equal "hoge", e.detail
    else
      assert_equal 1, 2
    end
  end

  def test_terminate_provider3
    # arrange
    $logger.info "* test_terminate_provider3 called."
    @remote_engine_mock_server.response_values[:result_code] = :SUCCEEDED
    @remote_engine_mock_server.response_values[:detail] = "hoge"
    @remote_engine_mock_server.response_values[:id] = "\x01\x02\x03\x04\x05"

    # act
    sut = ORiN3::RemoteEngine.new(@channel)
    begin
      sut.terminate_provider("\x01\x02\x03\x04\x05")
    rescue ORiN3::MessageClientError => e
      # assert
      $logger.info "Result code: #{e.result_code}"
      assert_equal :UNKNOUN, e.result_code
      $logger.info "Detail: #{e.detail}"
      #assert_equal "hoge", e.detail
    else
      assert_equal 1, 2
    end
  end
end