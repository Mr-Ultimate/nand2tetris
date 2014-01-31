# Encoding: utf-8

require 'spec_helper'
require 'translator/commands/add'
require 'unit/lib/translator/commands/shared_examples'

describe Translator::Commands::Add do

  let(:command) { Translator::Commands::Add.new }

  it_behaves_like 'a command'

  it 'should write the correct instructions for add' do
    expect_assembly %w(@SP AM=M-1 D=M A=A-1 M=D+M)
  end
end
