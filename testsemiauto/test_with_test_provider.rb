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

class ORiN3ProviderTest2 < Minitest::Test
  include Minitest::Hooks
  
  def before_all
    puts "......................."
    $logger.info "* before_all called."
    @controllers = {}
    @variables = {}

    $logger.info "* wakeup test provider."
    id = "B0EFA63C-6610-4167-9DA6-9DDC11D145B2"
    @version = "[1.0.0,2.0.0)"
    channel = GRPC::Core::Channel.new("localhost:7103", nil, :this_channel_is_insecure)
    remote_engine = ORiN3::RemoteEngine.new(channel)
    result = remote_engine.wakeup_provider(id, @version, "0.0.0.0", 0)
    $logger.info "* wakeup test provider done. [uri=#{result.provider_information.endpoints[0].uri}]"

    uri = URI.parse(result.provider_information.endpoints[0].uri)
    provider_channerl = GRPC::Core::Channel.new("#{uri.host}:#{uri.port}", nil, :this_channel_is_insecure)
    @root = ORiN3::ORiN3RootObject.attach(provider_channerl)
    $logger.info "* attached to test provider."

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
    after_all_core
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
      "ORiN3.Provider.Core.ForTestProvider.ORiN3Object.ForTestController, ORiN3.Provider.Core.ForTestProvider",
      "{ \"@Version\":\"1.0.0\" }")
    $logger.info "Controller created. [name=#{controller.name}]"
    @controllers[name] = controller
    return controller
  end

  def test_file
    $logger.info "* test_file called."
    controller = create_or_get_controller("test_file")
    current_dir = File.dirname(File.expand_path(__FILE__))
    full_path = File.join(current_dir, "testdata", "file.txt")
    file = controller.create_file("file",
      "ORiN3.Provider.Core.ForTestProvider.ORiN3Object.ForTestFile, ORiN3.Provider.Core.ForTestProvider",
      "{ \"@Version\":\"1.0.0\", \"Path\":\"#{full_path}\" }")

    $logger.info "aaa=#{file.orin3_object_type}"

    # get_length
    length = file.get_length
    $logger.info "File length: #{length}"
    assert_equal 10, length

    # read
    total_read = 0
    file.read do |buffer|
      $logger.info "buffer: #{buffer}"
      assert_equal "1234567890", buffer
      total_read += buffer.size
    end
    $logger.info "Total bytes read: #{total_read}"
    assert_equal length, total_read

    # seek
    total_read = 0
    file.seek(4)
    file.read do |buffer|
      $logger.info "buffer: #{buffer}"
      assert_equal "567890", buffer
      total_read += buffer.size
    end
    $logger.info "Total bytes read after seek: #{total_read}"
    assert_equal 6, total_read

    total_read = 0
    file.seek(-4, :END)
    file.read do |buffer|
      $logger.info "buffer: #{buffer}"
      assert_equal "7890", buffer
      total_read += buffer.size
    end
    $logger.info "Total bytes read after seek: #{total_read}"
    assert_equal 4, total_read

    total_read = 0
    file.seek(-2, :CURRENT)
    file.read do |buffer|
      $logger.info "buffer: #{buffer}"
      assert_equal "90", buffer
      total_read += buffer.size
    end
    $logger.info "Total bytes read after seek: #{total_read}"
    assert_equal 2, total_read

    # set_length
    file.set_length(20)
    assert_equal 20, file.get_length

    # write
    file.seek(10)
    file.write("987654")
    file.write("3210")
    total_read = 0
    file.seek(0)
    file.read do |buffer|
      $logger.info "buffer: #{buffer}"
      assert_equal "12345678909876543210", buffer
      total_read += buffer.size
    end
    $logger.info "Total bytes read after seek: #{total_read}"
    assert_equal 20, total_read

    file.set_length(10)

    # can_read, can_write
    assert_equal true, file.can_read
    assert_equal true, file.can_write
  end

  def test_stream
    $logger.info "* test_stream called."
    controller = create_or_get_controller("test_stream")
    stream = controller.create_stream("stream",
      "ORiN3.Provider.Core.ForTestProvider.ORiN3Object.ForTestStream, ORiN3.Provider.Core.ForTestProvider",
      "{ \"@Version\":\"1.0.0\" }")
    
    stream.read do |value|
      $logger.info "Received value: #{value}"
    end
  end

  def test_module
    $logger.info "* test_module called."
    controller = create_or_get_controller("test_module")
    orin3_module = controller.create_module("module",
      "ORiN3.Provider.Core.ForTestProvider.ORiN3Object.ForTestModule, ORiN3.Provider.Core.ForTestProvider",
      "{ \"@Version\":\"1.0.0\" }")

    $logger.info "Module.name: #{orin3_module.name}"
    $logger.info "Module.type_name: #{orin3_module.type_name}"
    $logger.info "Module.option: #{orin3_module.option}"
    $logger.info "Module.created_datetime: #{orin3_module.created_datetime.getlocal}"
    $logger.info "Module.orin3_object_type: #{orin3_module.orin3_object_type}"
    $logger.info "Module.id: #{orin3_module.id}"
    assert_equal "module", orin3_module.name
    assert_equal "ORiN3.Provider.Core.ForTestProvider.ORiN3Object.ForTestModule, ORiN3.Provider.Core.ForTestProvider", orin3_module.type_name
    assert_equal "{ \"@Version\":\"1.0.0\" }", orin3_module.option
  end
end