# Encoding: utf-8

require 'spec_helper'
require 'translator/commands/push'
require 'unit/lib/translator/commands/shared_examples'

describe Translator::Commands::Push do

  let(:command) { Translator::Commands::Push.new('constant', 123) }

  it_behaves_like 'a command'

  it 'should write the correct instructions for push constant' do
    expect_assembly %w(@123 D=A @SP AM=M+1 A=A-1 M=D)
  end

  it 'should write the correct instructions for a push local' do
    c = Translator::Commands::Push.new('local', 15)
    expect_assembly %w(@15 D=A @LCL A=M+D D=M @SP AM=M+1 A=A-1 M=D), c
  end

  it 'should write the correct instructions for a push argument' do
    c = Translator::Commands::Push.new('argument', 8)
    expect_assembly %w(@8 D=A @ARG A=M+D D=M @SP AM=M+1 A=A-1 M=D), c
  end

  it 'should write the correct instructions for a push this' do
    c = Translator::Commands::Push.new('this', 8)
    expect_assembly %w(@8 D=A @THIS A=M+D D=M @SP AM=M+1 A=A-1 M=D), c
  end

  it 'should write the correct instructions for a push that' do
    c = Translator::Commands::Push.new('that', 8)
    expect_assembly %w(@8 D=A @THAT A=M+D D=M @SP AM=M+1 A=A-1 M=D), c
  end

  it 'should write the correct instructions for a push temp' do
    c = Translator::Commands::Push.new('temp', 2)
    expect_assembly %w(@2 D=A @5 A=A+D D=M  @SP AM=M+1 A=A-1 M=D), c
  end

  it 'should raise a syntax error for an unknown segment' do
    expect do
      Translator::Commands::Push.new('bad', 2)
    end.to raise_error SyntaxError, 'VM Syntax Error: "bad" is an unknown segment.'
  end
end
