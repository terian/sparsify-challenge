# encoding: utf-8
#
# STEP 2-2
#
# Don't use Object#extend or Module#include in Sparsify::sparse,
# since they invalidate the method cache and severly harm the overall
# performance of your entire running application.
#

load File.expand_path('../../spec_helper.rb', __FILE__)

describe :Sparsify do
  let(:source) do
    {
      'foo' => { 'bar' => 'baz' }
    }
  end
  it 'should not call Object#extend' do
    Object.any_instance.should_not_receive(:extend)
    Sparsify::sparse(source)
  end
  it 'should not call Module#include' do
    Module.any_instance.should_not_receive(:include)
    Sparsify::sparse(source)
  end
end
