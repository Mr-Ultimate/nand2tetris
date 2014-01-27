# Encoding: utf-8

require 'spec_helper'
require 'translator/commands/equals'
require 'unit/lib/translator/commands/shared_examples'

describe Translator::Commands::Equals do

  let(:command) { Translator::Commands::Equals.new }

  it_behaves_like 'a command'

end
