# encoding: utf-8

($:).unshift(File.expand_path('../lib/', __FILE__))
require 'sparsify'

RSpec.configure do |config|
  config.color_enabled = true
  config.fail_fast = true
  config.formatter = :documentation
end
