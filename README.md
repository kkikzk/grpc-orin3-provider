# grpc-orin3-provider

`grpc-orin3-provider` is a Ruby client Gem that provides a wrapper for the ORiN3 gRPC interface. It enables seamless interaction with a variety of devices and resources, allowing users to leverage ORiN3 functionalities in a language-agnostic and platform-independent manner.

## Features

- **gRPC Wrapper**  
  Easily access the ORiN3 gRPC API through a Ruby client.

- **Multi-Device Support**  
  ORiN3 provides a unified interface to connect with diverse devices and resources, with broad applications across industries including manufacturing.

- **Cross-Platform Compatibility**  
  ORiN3 supports both Windows and Linux, and this Ruby client is designed for cross-platform use.

## Installation

Install the Gem by running:

```shell
gem install grpc-orin3-provider
```

Or add it to your Gemfile and run `bundle install`:

```ruby
gem 'grpc-orin3-provider'
```

### Usage

1. **Initialize the Client**  
   Connect to the ORiN3 provider by specifying the host and port.

   ```ruby
   # Shorten namespaces for readability
   module ORiN3
     include Grpc::Client::ORiN3
     include Grpc::Client::ORiN3::Provider
   end

   def main
     channel = GRPC::Core::Channel.new("localhost:7103", nil, :this_channel_is_insecure)
     remote_engine = ORiN3::RemoteEngine.new(channel)
     id = "B0EFA63C-6610-4167-9DA6-9DDC11D145B2"
     version = "[1.0.0,2.0.0)"
     result = remote_engine.wakeup_provider(id, version, "0.0.0.0", 0)
     puts "* wakeup test provider done. [uri=#{result.provider_information.endpoints[0].uri}]"
     
     uri = URI.parse(result.provider_information.endpoints[0].uri)
     provider_channerl = GRPC::Core::Channel.new("#{uri.host}:#{uri.port}", nil, :this_channel_is_insecure)
     root = ORiN3::ORiN3RootObject.attach(provider_channerl)
     
     puts "Root.name: #{root.name}"
     puts "Root.type_name: #{root.type_name}"
     puts "Root.option: #{root.option}"
     puts "Root.created_datetime: #{root.created_datetime.getlocal}"
     puts "Root.orin3_object_type: #{root.orin3_object_type}"
     puts "Root.id: #{root.id}"
   rescue ORiN3::MessageClientError => e
     abort "ERROR: #{e.message}"
   end
   ```

## About ORiN3

ORiN3 (Open Robot/Resource interface for the Network) is an open standard communication interface designed to facilitate seamless communication with robots and resources on a network. Built with gRPC, ORiN3 provides cross-platform capabilities, making it suitable for various industries and applications. For more details, see the [ORiN3 GitHub repository](https://github.com/ORiNConsortium/ORiN3).

## License

`grpc-orin3-provider` is released under the MIT License. For details, please see the [LICENSE](LICENSE.txt) file.