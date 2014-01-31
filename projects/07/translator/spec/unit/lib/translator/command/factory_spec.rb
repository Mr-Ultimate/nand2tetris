# Encoding: utf-8

require 'spec_helper'
require 'translator/command/factory'

describe Translator::Command::Factory do

  let(:factory) { Translator::Command::Factory.new }

  it 'should fail if invalid line provided' do
    line = double
    line.should_receive(:valid?).and_return(false)
    expect do
      factory.build(line)
    end.to raise_error ArgumentError, 'Invalid line provided.'
  end

  it 'should fail for an unknown command' do
    line = double
    line.should_receive(:valid?).and_return(true)
    line.should_receive(:instruction).and_return('bad_command')
    expect do
      factory.build(line)
    end.to raise_error SyntaxError, 'VM Syntax Error: "bad_command" is an unknown command.'
  end
end
