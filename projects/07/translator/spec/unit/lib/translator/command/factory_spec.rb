# Encoding: utf-8

require 'spec_helper'
require 'translator/command/factory'

describe Translator::Command::Factory do

  let(:factory) { Translator::Command::Factory.new }

  it 'should return nil for an empty string, new line, or comments' do
    factory.build('').should be_nil
    factory.build("\n").should be_nil
    factory.build("   //some comments \n").should be_nil
  end

  it 'should fail for an unknown command' do
    expect do
      factory.build("  bad_command //some comments \n").should be_nil
    end.to raise_error SyntaxError, 'VM Syntax Error: "bad_command" is an unknown command.'
  end
end
