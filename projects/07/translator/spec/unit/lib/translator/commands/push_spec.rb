# Encoding: utf-8

require 'spec_helper'
require 'translator/commands/push'
require 'unit/lib/translator/commands/shared_examples'

describe Translator::Commands::Push do

  let(:command) { Translator::Commands::Push.new('constant', 123) }

  it_behaves_like 'a command'

  it 'should write the correct instructions for push' do
    expect_assembly %w(@123 D=A @SP AM=M+1 A=A-1 M=D)
  end
end
