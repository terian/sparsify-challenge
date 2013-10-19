# encoding: utf-8

# Ensure Ruby version is sufficient
ruby_version_requirement = Gem::Requirement.new('>= 1.9.3')
current_ruby_version = Gem::Version.new("#{RUBY_VERSION}")

if ruby_version_requirement.satisfied_by?(current_ruby_version)
  $stderr.puts "\x1b[32m[✔ Ruby version requirement satisfied.]\x1b[0m"
else
  $stderr.puts "\x1b[31m[✘ Ruby version #{current_ruby_version} " +
               "does not meet the requirement #{ruby_version_requirement}]" +
               "\x1b[0m"
  $stderr.puts "Please install a matching version."
  exit 1
end

require 'rspec/core'
require 'rspec/core/rake_task'

# Wire up specs to ensure that each step has the previous step
# as a prerequisite.
steps =  %w(
            step-1
            step-2
            step-3
            step-4
            step-5
          )

(steps.unshift(nil)).each_cons(2) do |prereq, current|
  desc "Run specs for challenge #{current}"
  RSpec::Core::RakeTask.new(current) do |spec|
    spec.pattern = FileList["spec/#{current}/*_spec.rb"]
    # spec.fail_fast = true
    spec.verbose = true
  end
  prereq && task(current => prereq)
end
