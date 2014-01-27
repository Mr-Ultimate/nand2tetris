# Encoding: utf-8

require 'spec_helper'
require 'translator/commands/greater_than'
require 'unit/lib/translator/commands/shared_examples'

describe Translator::Commands::GreaterThan do

  let(:command) { Translator::Commands::GreaterThan.new }

  it_behaves_like 'a command'

end
