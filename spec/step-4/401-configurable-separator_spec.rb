# encoding: utf-8
#
# STEP 4
#
# Make the separator used to concatenate key-parts configurable, since a new
# consumer of our library wants to use the pipe character (0x7c) as a key
# separator instead of a dot (0x2e).
#

load File.expand_path('../../spec_helper.rb', __FILE__)

describe :Sparsify do
  describe '::sparse' do
    context 'with pipe separator' do
      let(:source) do
        { 'foo' => { 'bar' => {} } }
      end
      let(:intended_result) do
        { 'foo|bar' => {} }
      end
      context 'the result' do
        let(:the_result) { Sparsify::sparse(source, separator: '|') }
        subject { the_result }
        it 'should not omit the node' do
          the_result.should eq intended_result
        end
      end
    end
  end

  describe '::unsparse' do
    context 'empty hash nodes' do
      let(:source) do
        { 'foo|bar' => {} }
      end
      let(:intended_result) do
        { 'foo' => { 'bar' => {} } }
      end
      context 'the result' do
        let(:the_result) { Sparsify::unsparse(source, separator: '|') }
        subject { the_result }
        it 'should not omit the node' do
          the_result.should eq intended_result
        end
      end
    end
  end
end
