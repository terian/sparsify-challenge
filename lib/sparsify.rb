# encoding: utf-8

module Sparsify
  
  def self.sparse(source, options = {separator: "."})
    @result = {}
    @separator = options[:separator]
    source.each do |key, value|
      unroll_hash(sep_escape(key), value)
    end
    @result
  end

  def self.unroll_hash(key, value)
    if value.is_a? Hash and !value.empty?
      value.each do |inner_key, inner_value|
        unroll_hash(key + @separator + sep_unescape(inner_key), inner_value)
      end
    else
      @result.merge!({key => sep_escape(value)})
    end
  end

  def self.unsparse(source, options = {separator: "."})
    result = {}
    @separator = options[:separator]
    source.each do |key, value|
      result = deep_merge(result, rehash(key, value))
    end
    result
  end

  def self.rehash(key, value)
    top = find_top(key)
    if top != key
      {sep_unescape(top) => rehash(key[top.length + 1..-1], value)}
    else
      {sep_unescape(key) => sep_unescape(value)}
    end
  end

  def self.find_top(str)
    tokens = str.split(@separator)
    return str if tokens.length == 1
    tok = tokens.first
    if tok.end_with?("\\")
      tok + "#{@separator}" + find_top(tokens[1..-1].join(@separator))
    else
      tok
    end
  end


  def self.sep_escape(str)
    if str.is_a? String
      str = str.gsub('\\', '\\\\\\\\')
      str.gsub(@separator, Regexp.escape(@separator))
    else
      str
    end
  end

  def self.sep_unescape(str)
    if str.is_a? String
      str = str.gsub('\\\\', '\\')
      str.gsub("\\#{@separator}", @separator)
    else
      str
    end
  end

  # from these fine folks:
  # https://www.ruby-forum.com/topic/142809
  def self.deep_merge(base_hash, addition)
    merger = proc { |key, v1, v2| Hash === v1 && Hash === v2 ? v1.merge(v2, &merger) : v2 }
    base_hash.merge(addition, &merger)
  end

end
