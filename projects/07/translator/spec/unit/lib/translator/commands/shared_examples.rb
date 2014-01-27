# Encoding: utf-8

shared_examples 'a command' do
  it 'should respond to translate' do
    command.should respond_to :translate
  end
end

def expect_assembly(instructions)
  output = double File
  instructions.each do |instruction|
    output.should_receive(:write).with("#{instruction}\n")
  end
  command.translate(output)
end
