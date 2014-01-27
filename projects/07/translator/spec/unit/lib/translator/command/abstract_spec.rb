# Encoding: utf-8

require 'spec_helper'
require 'translator/command/abstract'

describe Translator::Command::Abstract do

  it 'should output lines to a file' do
    class TestCommand < Translator::Command::Abstract
      def initialize
        @lines =  %w(foo bar)
      end
    end

    output = double File
    %w(foo bar).each do |instruction|
      output.should_receive(:write).with("#{instruction}\n")
    end
    TestCommand.new.translate(output)
  end
end
