# Encoding: utf-8

require 'spec_helper'
require 'translator/commands/negate'
require 'unit/lib/translator/commands/shared_examples'

describe Translator::Commands::Negate do

  let(:command) { Translator::Commands::Negate.new }

  it_behaves_like 'a command'

  it 'should write the correct instructions for neg' do
    expect_assembly %w(@SP A=M-1 M=-M)
  end

end
