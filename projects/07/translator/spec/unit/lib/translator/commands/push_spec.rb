# Encoding: utf-8

require 'spec_helper'
require 'translator/commands/push'

describe Translator::Commands::Push do
  it 'can be instantiated with a segment and value' do
    output = double File
    %w(@123 D=A @SP AM=M+1 A=A-1 M=D).each do |instruction|
      output.should_receive(:write).with("#{instruction}\n")
    end
    push = Translator::Commands::Push.new('constant', 123)
    push.translate(output)
  end
end
