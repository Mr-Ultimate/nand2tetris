# Encoding: utf-8

shared_examples 'a command' do
  it 'should respond to translate' do
    command.should respond_to :translate
  end
end

def expect_assembly(instructions, specific_command = nil)
  output = double File
  instructions.each do |instruction|
    output.should_receive(:write).with("#{instruction}\n")
  end
  specific_command ||= command
  specific_command.translate(output)
end
