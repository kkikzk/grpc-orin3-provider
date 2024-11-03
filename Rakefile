# frozen_string_literal: true

require "bundler/gem_tasks"
require 'bundler/setup'
require 'rake'
require 'fileutils'

ROOT_DIR = File.expand_path(__dir__)
CURRENT_DIR = Dir.pwd

task default: %i[]

# protoのビルド方法
# ORiN協議会のORiN3レポジトリをクローンして、以下のrakeコマンドを実行する
# bundle exec rake "grpc:build[~/Repos/ORiN3/src/Design.ORiN3.Common/]"
# bundle exec rake "grpc:build[~/Repos/ORiN3/src/Design.ORiN3.Provider/]"
# bundle exec rake "grpc:build[~/Repos/ORiN3/src/Message.ORiN3.Provider/]"
# bundle exec rake "grpc:build[~/Repos/ORiN3/src/Message.ORiN3.RemoteEngine/]"
namespace :grpc do
  desc "Build gRPC Ruby files"
  task :build, [:target_folder] do |t, args|
    # 引数が指定されていなければエラーを出力して終了
    unless args[:target_folder]
      abort "Error: target_folder argument is required. Usage: rake grpc:guild[<target_folder>]"
    end

    # ユーザが指定したフォルダを取得し、末端のフォルダ名のみ取得
    target_folder = File.expand_path(args[:target_folder])
    target_folder_name = File.basename(target_folder)  # 末端のフォルダ名を取得
    puts "ターゲット: " + target_folder

    # 出力ディレクトリのパスを構成
    output_dir = File.join(ROOT_DIR, 'gen', target_folder_name)
    puts "出力先: " + output_dir
  
    # 出力ディレクトリが存在しない場合は作成
    FileUtils.mkdir_p(output_dir) unless Dir.exist?(output_dir)
  
    # grpc_tools_ruby_protocコマンドを実行
    Dir.chdir(target_folder) do
      system(
        "grpc_tools_ruby_protoc -I./ -I../ --ruby_out=#{output_dir} --grpc_out=#{output_dir} */*.proto"
      )
    end
  end
end
