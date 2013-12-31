require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts 'Run `bundle install` to install missing gems'
  exit e.status_code
end

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')
require 'assembler/application'

require 'rspec/expectations'
require 'aruba'
require 'aruba/cucumber'
require 'aruba/in_process'

Aruba::InProcess.main_class = Assembler::Application
Aruba.process = Aruba::InProcess

Before do
  dir = 'build/tmp'
  FileUtils.rm_rf dir if File.directory?(dir)
  @dirs = [dir]
end
