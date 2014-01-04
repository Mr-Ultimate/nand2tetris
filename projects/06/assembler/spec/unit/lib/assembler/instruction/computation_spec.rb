# Encoding: utf-8

require 'spec_helper'
require 'assembler/instruction/computation'
require 'unit/lib/assembler/instruction/shared_examples'

describe Assembler::Instruction::Computation do

  let(:instruction) { Assembler::Instruction::Computation.new }
  let(:symbol_table_stub) { double 'Assembler::SymbolTable' }

  it_behaves_like 'an instruction'

  it 'can set the destination code' do
    instruction.destination = 'AMD'
    instruction.destination.should eq 'AMD'
  end

  it 'can set the computation code' do
    instruction.computation = 'D+A'
    instruction.computation.should eq 'D+A'
  end

  it 'can set the jump code' do
    instruction.jump = 'JEQ'
    instruction.jump.should eq 'JEQ'
  end

  it 'should throw a syntax error if any code is not in all caps' do
    expect { instruction.jump = 'jeq' }.to raise_error SyntaxError, 'Assembly mnemonics must be written in uppercase, "jeq" is not!'
    expect { instruction.destination = 'amd' }.to raise_error SyntaxError, 'Assembly mnemonics must be written in uppercase, "amd" is not!'
    expect { instruction.computation = 'd+a' }.to raise_error SyntaxError, 'Assembly mnemonics must be written in uppercase, "d+a" is not!'
  end

  it 'if nothing is set it should throw an invalid computation code error' do
    expect do
      instruction.encode(symbol_table_stub)
    end.to raise_error SyntaxError, 'A computation code must be provided.'
  end

  it 'should encode the most basic computation code' do
    instruction.computation = '0'
    instruction.encode(symbol_table_stub).should eq '1110101010000000'
  end

  it 'should encode all of the computation codes' do
    {
     '0' => '0101010',
     '1' => '0111111',
     '-1' => '0111010',
     'D' => '0001100',
     'A' => '0110000',
     '!D' => '0001101',
     '!A' => '0110001',
     '-D' => '0001111',
     '-A' => '0110011',
     'D+1' => '0011111',
     'A+1' => '0110111',
     'D-1' => '0001110',
     'A-1' => '0110010',
     'D+A' => '0000010',
     'D-A' => '0010011',
     'A-D' => '0000111',
     'D&A' => '0000000',
     'D|A' => '0010101',
     'M' => '1110000',
     '!M' => '1110001',
     '-M' => '1110011',
     'M+1' => '1110111',
     'M-1' => '1110010',
     'D+M' => '1000010',
     'D-M' => '1010011',
     'M-D' => '1000111',
     'D&M' => '1000000',
     'D|M' => '1010101'
    }.each do |code, encoded|
      i = Assembler::Instruction::Computation.new
      i.computation = code
      i.encode(symbol_table_stub).should eq "111#{encoded}000000"
    end
  end

  it 'should encode all the destination codes' do
    {
          'M' => '001',
          'D' => '010',
          'MD' => '011',
          'A' => '100',
          'AM' => '101',
          'AD' => '110',
          'AMD' => '111'
    }.each do |code, encoded|
      i = Assembler::Instruction::Computation.new
      i.computation = 'D&A'
      i.destination = code
      i.encode(symbol_table_stub).should eq "1110000000#{encoded}000"
    end
  end

  it 'should encode all of the jump codes' do
    {
      'JGT' => '001',
      'JEQ' => '010',
      'JGE' => '011',
      'JLT' => '100',
      'JNE' => '101',
      'JLE' => '110',
      'JMP' => '111'
    }.each do |code, encoded|
      i = Assembler::Instruction::Computation.new
      i.computation = 'D&A'
      i.jump = code
      i.encode(symbol_table_stub).should eq "1110000000000#{encoded}"
    end
  end

  it 'should encode a more complicated command' do
    instruction.computation = 'D'
    instruction.jump = 'JGT'
    instruction.encode(symbol_table_stub).should eq '1110001100000001'
  end

  it 'should support reverse order of + & and | operations' do
    {
     '1+D' => '0011111',
     '1+A' => '0110111',
     'A+D' => '0000010',
     'A&D' => '0000000',
     'A|D' => '0010101',
     '1+M' => '1110111',
     'M+D' => '1000010',
     'M&D' => '1000000',
     'M|D' => '1010101'
    }.each do |code, encoded|
      i = Assembler::Instruction::Computation.new
      i.computation = code
      i.encode(symbol_table_stub).should eq "111#{encoded}000000"
    end
  end

  it 'should raise a syntax error if computation code is unknown' do
    expect do
      instruction.computation = 'BAD'
      instruction.encode(symbol_table_stub)
    end.to raise_error SyntaxError, '"BAD" is not a valid computation code!'
  end

  it 'should raise a syntax error if jump code is unknown' do
    expect do
      instruction.computation = 'D'
      instruction.jump = 'BAD'
      instruction.encode(symbol_table_stub)
    end.to raise_error SyntaxError, '"BAD" is not a valid jump code!'
  end

  it 'should raise a syntax error if code is unknown' do
    expect do
      instruction.computation = 'D'
      instruction.destination = 'BAD'
      instruction.encode(symbol_table_stub)
    end.to raise_error SyntaxError, '"BAD" is not a valid destination code!'
  end
end
