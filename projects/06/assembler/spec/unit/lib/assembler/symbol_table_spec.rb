# Encoding: utf-8

require 'spec_helper'
require 'assembler/symbol_table'

describe Assembler::SymbolTable do

  before(:each) do
    @st = Assembler::SymbolTable.new
  end

  it 'should respond to the api functions' do
    @st = Assembler::SymbolTable.new
    @st.should respond_to :add_entry
    @st.should respond_to :contains?
    @st.should respond_to :address_for
  end

  it 'should respond to the sudo regi@ster symbols' do
    @st = Assembler::SymbolTable.new
    (0..15).to_a.each do |n|
      symbol = "R#{n}"
      @st.contains?(symbol).should be_true
      @st.address_for(symbol).should eq n
    end
  end

  it 'should respond to the other predefined symbols' do
    {
      'SP' => 0,
      'LCL' => 1,
      'ARG' => 2,
      'THIS' => 3,
      'THAT' => 4,
      'SCREEN' => 16_384,
      'KBD' => 24_576
    }.each do |symbol, address|
      @st.contains?(symbol).should be_true
      @st.address_for(symbol).should eq address
    end
  end

  it 'should raise an error if a symbol is not in the table' do
    expect do
      @st.address_for('bad')
    end.to raise_error ArgumentError, 'The symbol, "bad", can not be found!'
  end

  it 'should return false if a the table does not contain a key' do
    @st.contains?('nope').should be_false
  end

  it 'should return an address for the provided key' do
    @st.add_entry('foo', 123)
    @st.add_entry('bar', 612)
    @st.contains?('foo').should be_true
    @st.address_for('bar').should eq 612
  end

  it 'should add a reference to the next available ram address' do
    @st.add_entry('foo', 123)
    @st.add_reference('baz')
    @st.add_reference('bip')
    @st.address_for('bip').should eq 17

  end
end
