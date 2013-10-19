# encoding: utf-8
#
# STEP 2-2
#
# Make sure your Sparsify::sparse and Sparsify::unsparse implementations
# can round-trip data.
#

load File.expand_path('../../spec_helper.rb', __FILE__)

describe :Sparsify do
  let(:source_hash) do
    {
      'array'   => [7,8,9],
      'string'  => 'rope',
      'integer' => 42,
      'float'   => 2.71828,
      'nil'     => nil,
      'boolean' => true,
      'hash'    => {
        'hash'    => {
          'array'   => [1,2,3],
          'string'  => 'theory',
          'integer' => 42,
          'float'   => 3.1415926,
          'nil'     => nil,
          'boolean' => true
        },
        'array'   => [4,5,6],
        'string'  => 'cheese',
        'integer' => 17,
        'float'   => 6.02214129e23,
        'nil'     => nil
      }
    }
  end

  let(:round_trip_result) do
    Sparsify::unsparse(Sparsify::sparse(source_hash))
  end
  context 'the round trip result' do
    subject { round_trip_result }
    it { should eq source_hash }
  end
end
