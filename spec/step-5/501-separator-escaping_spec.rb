# encoding: utf-8
#
# STEP 5
#
# Ensure that the separator character gets escaped, if present in a nested key.
# For this implementation, we will use backslash escapes, which means you need
# to escape your separator and the backslash character.
#

load File.expand_path('../../spec_helper.rb', __FILE__)

describe :Sparsify do
  context 'separator in key' do
    describe '::sparse' do
      let(:source) do
        { 'foo.foo' => { 'bar' => {} } }
      end
      let(:intended_result) do
        { 'foo\\.foo.bar' => {} }
      end
      context 'the result' do
        let(:the_result) { Sparsify::sparse(source) }
        subject { the_result }
        it 'should backslash-escape the separator' do
          the_result.should eq intended_result
        end
      end
      context 'with custom separator' do
        let(:source) do
          { 'foo|foo.foo' => { 'bar' => {} } }
        end
        let(:intended_result) do
          { 'foo\\|foo.foo|bar' => {} }
        end
        context 'the result' do
          let(:the_result) { Sparsify::sparse(source, separator: '|') }
          subject { the_result }
          it 'should backslash-escape the separator' do
            the_result.should eq intended_result
          end
        end
      end
    end

    describe '::unsparse' do
      let(:source) do
        { 'foo\\.foo.bar' => {} }
      end
      let(:intended_result) do
        { 'foo.foo' => { 'bar' => {} } }
      end
      context 'the result' do
        let(:the_result) { Sparsify::unsparse(source) }
        subject { the_result }
        it 'should not see the backslashed separator as a separator' do
          the_result.should eq intended_result
        end
      end
      context 'with custom separator' do
        let(:source) do
          { 'foo\\|foo.foo|bar' => {} }
        end
        let(:intended_result) do
          { 'foo|foo.foo' => { 'bar' => {} } }
        end
        context 'the result' do
          let(:the_result) { Sparsify::unsparse(source, separator: '|') }
          subject { the_result }
          it 'should backslash-escape the separator' do
            the_result.should eq intended_result
          end
        end
      end
    end
  end

  context 'escape character in key' do
    describe '::sparse' do
      let(:source) do
        { 'foo\\foo' => {  'bar' => {} } }
      end
      let(:intended_result) do
        { 'foo\\\\foo.bar' => {} }
      end
      context 'the result' do
        let(:the_result) { Sparsify::sparse(source) }
        subject { the_result }
        it 'should escape the escape character' do
          the_result.should eq intended_result
        end
      end
    end

    describe '::unsparse' do
      let(:source) do
        { 'foo\\\\foo.bar' => {} }
      end
      let(:intended_result) do
        { 'foo\\foo' => { 'bar' => {} } }
      end
      context 'the result' do
        let(:the_result) { Sparsify::unsparse(source) }
        subject { the_result }
        it 'should unescape the escape character' do
          should eq intended_result
        end
      end
    end
  end
end
