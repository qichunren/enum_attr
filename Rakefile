require "rubygems"
require 'rake'  
require 'rspec/core/rake_task'

begin
  require 'jeweler'

  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "enum_attr"
    gemspec.summary = "enum_attr is a Ruby gem to manage enum column for active_record."
    gemspec.description = "A Rails plugin which brings easy-to-use enum-like functionality to ActiveRecord models (now compatible with rails 3, ruby 1.9 and jruby). ."
    gemspec.email = "whyruby@gmail.com"
    gemspec.homepage = "https://github.com/qichunren/enum_attr"
    gemspec.authors = ["qichunren"]
  end

rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end 

task :default => :spec

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = Dir.glob('spec/**/*_spec.rb')
  t.rspec_opts = '--format progress -c'
end