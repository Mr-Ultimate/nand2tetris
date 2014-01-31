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

  [
    ['add', Translator::Commands::Add],
    ['and', Translator::Commands::And],
    ['eq', Translator::Commands::Equals],
    ['gt', Translator::Commands::GreaterThan],
    ['lt', Translator::Commands::LessThan],
    ['neg', Translator::Commands::Negate],
    ['not', Translator::Commands::Not],
    ['or', Translator::Commands::Or],
    ['pop static 3', Translator::Commands::Pop],
    ['push static 123', Translator::Commands::Push],
    ['sub', Translator::Commands::Subtract]
  ].each do |clean_command, result|
    it "should return the correct command for: #{clean_command}" do
      line = Translator::SourceLine.new("   #{clean_command}    //some random comment \n", 'some_file', 20)
      factory.build(line).should be_an_instance_of result
    end
  end
end
