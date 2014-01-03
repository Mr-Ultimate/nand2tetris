# Encoding: utf-8

shared_examples 'an instruction' do
  it 'should respond to prepare and encode' do
    instruction.should respond_to :prepare_line
    instruction.should respond_to :encode
  end
end
