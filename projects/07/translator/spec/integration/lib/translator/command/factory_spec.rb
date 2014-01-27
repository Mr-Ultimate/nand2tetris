# Encoding: utf-8

require 'spec_helper'
require 'translator/command/factory'
require 'translator/commands/push'
require 'translator/commands/add'

describe Translator::Command::Factory do

  let(:factory) { Translator::Command::Factory.new }

  it 'should return the push command' do
    make_command('push constant 123').should be_an_instance_of Translator::Commands::Push
  end

  it 'should return the add command' do
    make_command('add').should be_an_instance_of Translator::Commands::Add
  end
end

def make_command(clean_command)
  factory.build("   #{clean_command}    //some random comment \n")
end
