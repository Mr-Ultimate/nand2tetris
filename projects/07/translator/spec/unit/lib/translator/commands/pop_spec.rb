# Encoding: utf-8

require 'spec_helper'
require 'translator/commands/pop'
require 'unit/lib/translator/commands/shared_examples'

describe Translator::Commands::Pop do

  let(:command) { Translator::Commands::Pop.new('local', 123) }

  it_behaves_like 'a command'

  it 'should write the correct instructions for pop local ' do
    expect_assembly %w(@123 D=A @LCL D=M+D @R15 M=D @SP AM=M-1 D=M @R15 A=M M=D)
  end

  it 'should write the correct instructions for a pop argument' do
    c = Translator::Commands::Pop.new('argument', 20)
    expect_assembly %w(@20 D=A @ARG D=M+D @R15 M=D @SP AM=M-1 D=M @R15 A=M M=D), c
  end

  it 'should write the correct instructions for a pop this' do
    c = Translator::Commands::Pop.new('this', 20)
    expect_assembly %w(@20 D=A @THIS D=M+D @R15 M=D @SP AM=M-1 D=M @R15 A=M M=D), c
  end

  it 'should write the correct instructions for a pop that' do
    c = Translator::Commands::Pop.new('that', 20)
    expect_assembly %w(@20 D=A @THAT D=M+D @R15 M=D @SP AM=M-1 D=M @R15 A=M M=D), c
  end

  it 'should write the correct instructions for a pop temp' do
    c = Translator::Commands::Pop.new('temp', 2)
    expect_assembly %w(@2 D=A @5 D=A+D @R15 M=D @SP AM=M-1 D=M @R15 A=M M=D), c
  end

  it 'should raise a syntax error for an unknown segment' do
    expect do
      Translator::Commands::Pop.new('bad', 2)
    end.to raise_error SyntaxError, 'VM Syntax Error: "bad" is an unknown segment.'
  end
end
