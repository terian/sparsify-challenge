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
    if value.is_a? Hash and !value.empty?
      value.each do |inner_key, inner_value|
        unroll_hash(key + "." + inner_key, inner_value)
      end
    else
      @result.merge!({key => value})
    end
  end

  def self.unsparse(source)
    result = {}
    source.each do |key, value|
      result = deep_merge(result, rehash(key, value))
    end
    result
  end

  def self.rehash(key, value)
    if key.include?(".")
      top = key.split(".").first
      {top => rehash(key[top.length + 1..-1], value)}
    else
      {key => value}
    end
  end

  # from these fine folks:
  # https://www.ruby-forum.com/topic/142809
  def self.deep_merge(base_hash, addition)
    merger = proc { |key, v1, v2| Hash === v1 && Hash === v2 ? v1.merge(v2, &merger) : v2 }
    base_hash.merge(addition, &merger)
  end

end