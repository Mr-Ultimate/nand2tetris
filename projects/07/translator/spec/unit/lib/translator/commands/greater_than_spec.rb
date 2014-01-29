# Encoding: utf-8

require 'spec_helper'
require 'translator/commands/greater_than'
require 'unit/lib/translator/commands/shared_examples'

describe Translator::Commands::GreaterThan do

  let(:command) { Translator::Commands::GreaterThan.new('name_54') }

  it_behaves_like 'a command'

  it 'should write the correct instructions for push' do
    expect_assembly %w(@SP AM=M-1 D=M A=A-1 D=M-D M=0 @END_GT_name_54 D;JLE @SP A=M-1 M=-1 (END_GT_name_54))
  end
end
