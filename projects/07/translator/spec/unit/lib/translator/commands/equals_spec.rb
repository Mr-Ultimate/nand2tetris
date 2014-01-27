# Encoding: utf-8

require 'spec_helper'
require 'translator/commands/equals'
require 'unit/lib/translator/commands/shared_examples'

describe Translator::Commands::Equals do

  let(:command) { Translator::Commands::Equals.new }

  it_behaves_like 'a command'

  it 'should write the correct instructions for push' do
    expect_assembly %w(@SP AM=M-1 D=M A=A-1 D=M-D M=0 @END_EQ D;JNE @SP A=M-1 M=-1 (END_EQ))
  end

end
