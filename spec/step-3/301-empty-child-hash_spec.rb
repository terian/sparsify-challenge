# encoding: utf-8
#
# STEP 3
#
# Ensure that empty hashes embedded in your source hash
# don't get dropped from the result.
#

load File.expand_path('../../spec_helper.rb', __FILE__)

describe :Sparsify do
  context 'empty hash nodes' do
    describe '::sparse' do
      let(:source) do
        { 'foo' => { 'bar' => {} } }
      end
      let(:intended_result) do
        { 'foo.bar' => {} }
      end
      context 'the result' do
        let(:the_result) { Sparsify::sparse(source) }
        subject { the_result }
        it 'should not omit the node' do
          the_result.should eq intended_result
        end
      end
    end
  end

  describe '::unsparse' do
    let(:source) do
      { 'foo.bar' => {} }
    end
    let(:intended_result) do
      { 'foo' => { 'bar' => {} } }
    end
    context 'the result' do
      let(:the_result) { Sparsify::unsparse(source) }
      subject { the_result }
      it 'should not omit the node' do
        the_result.should eq intended_result
      end
    end
  end
end
