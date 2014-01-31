# Encoding: utf-8

require 'spec_helper'
require 'translator/commands/and'
require 'unit/lib/translator/commands/shared_examples'

describe Translator::Commands::And do

  let(:command) { Translator::Commands::And.new }

  it_behaves_like 'a command'

  it 'should write the correct instructions for push' do
    expect_assembly %w(@SP AM=M-1 D=M A=A-1 M=M&D)
  end
end
