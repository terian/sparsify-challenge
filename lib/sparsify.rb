# encoding: utf-8

module Sparsify

  def self.sparse(source)
    @result = {}
    source.each do |key, value|
      unroll_hash(key, value)
    end
    @result
  end

  def self.unroll_hash(key, value)
    if value.is_a? Hash
      value.each do |inner_key, inner_value|
        unroll_hash(key + "." + inner_key, inner_value)
      end
    else
      @result.merge!({key => value})
    end
  end

end