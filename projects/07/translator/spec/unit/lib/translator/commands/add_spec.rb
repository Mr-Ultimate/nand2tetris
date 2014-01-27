# Encoding: utf-8

require 'spec_helper'
require 'translator/commands/add'

describe Translator::Commands::Add do

  it 'should write the correct instructions for add' do
    output = double File
    %w(@SP AM=M-1 D=M M=0 A=A-1 M=D+M).each do |instruction|
      output.should_receive(:write).with("#{instruction}\n")
    end
    add = Translator::Commands::Add.new
    add.translate(output)
  end
end
