# frozen_string_literal: true

require_relative "lib/grpc/orin3/provider/version"

Gem::Specification.new do |spec|
  spec.name = "grpc-orin3-provider"
  spec.version = Grpc::Orin3::Provider::VERSION
  spec.authors = ["KAKEI Kazuki"]
  spec.email = ["kkikzk@gmail.com"]

  spec.summary = "A gRPC client for ORiN3 devices."
  spec.description = "This gem provides a gRPC client to interact with ORiN3 devices, enabling seamless communication and data exchange."
  spec.homepage = "https://github.com/kkikzk/grpc-orin3-provider"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"
  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib", "gen"]

  spec.add_dependency "grpc"
end
