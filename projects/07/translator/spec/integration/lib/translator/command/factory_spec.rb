# Encoding: utf-8

require 'spec_helper'
require 'translator/source_line'
require 'translator/command/factory'

require 'translator/commands/add'
require 'translator/commands/and'
require 'translator/commands/equals'
require 'translator/commands/greater_than'
require 'translator/commands/less_than'
require 'translator/commands/negate'
require 'translator/commands/not'
require 'translator/commands/or'
require 'translator/commands/pop'
require 'translator/commands/push'
require 'translator/commands/subtract'

describe Translator::Command::Factory do

  let(:factory) { Translator::Command::Factory.new }

  it 'should return the add command' do
    make_command('add').should be_an_instance_of Translator::Commands::Add
  end

  it 'should return the and command' do
    make_command('and').should be_an_instance_of Translator::Commands::And
  end

  it 'should return the eq command' do
    make_command('eq').should be_an_instance_of Translator::Commands::Equals
  end

  it 'should return the gt command' do
    make_command('gt').should be_an_instance_of Translator::Commands::GreaterThan
  end

  it 'should return the lt command' do
    make_command('lt').should be_an_instance_of Translator::Commands::LessThan
  end

  it 'should return the neg command' do
    make_command('neg').should be_an_instance_of Translator::Commands::Negate
  end

  it 'should return the not command' do
    make_command('not').should be_an_instance_of Translator::Commands::Not
  end

  it 'should return the or command' do
    make_command('or').should be_an_instance_of Translator::Commands::Or
  end

  it 'should return the pop command' do
    make_command('pop local 3').should be_an_instance_of Translator::Commands::Pop
  end

  it 'should return the push command' do
    make_command('push constant 123').should be_an_instance_of Translator::Commands::Push
  end

  it 'should return the sub command' do
    make_command('sub').should be_an_instance_of Translator::Commands::Subtract
  end

end

def make_command(clean_command)
  line = Translator::SourceLine.new("   #{clean_command}    //some random comment \n", 'some_file', 20)
  factory.build(line)
end
