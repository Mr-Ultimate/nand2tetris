# Encoding: utf-8

require 'spec_helper'
require 'translator/commands/not'
require 'unit/lib/translator/commands/shared_examples'

describe Translator::Commands::Not do

  let(:command) { Translator::Commands::Not.new }

  it_behaves_like 'a command'

  it 'should write the correct instructions for neg' do
    %w(@SP A=M-1 M=!M)
  end

end
