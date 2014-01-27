# Encoding: utf-8

require 'spec_helper'
require 'translator/commands/less_than'
require 'unit/lib/translator/commands/shared_examples'

describe Translator::Commands::LessThan do

  let(:command) { Translator::Commands::LessThan.new }

  it_behaves_like 'a command'

  it 'should write the correct instructions for push' do
    expect_assembly %w(@SP AM=M-1 D=M A=A-1 D=M-D M=0 @END_LT D;JGE @SP A=M-1 M=-1 (END_LT))
  end

end
