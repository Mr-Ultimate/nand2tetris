# Encoding: utf-8

require 'spec_helper'
require 'translator/commands/less_than'
require 'unit/lib/translator/commands/shared_examples'

describe Translator::Commands::LessThan do

  let(:command) { Translator::Commands::LessThan.new }

  it_behaves_like 'a command'

end
