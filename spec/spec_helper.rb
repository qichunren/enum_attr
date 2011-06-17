# encoding: utf-8 
require 'active_record'  
require 'yaml'        
require 'rspec'   
require 'logger'    

require File.expand_path("../../lib/enum_attr", __FILE__)

dbconfig = YAML::load(File.open(File.dirname(__FILE__) + "/database.yml"))    
ActiveRecord::Base.establish_connection(dbconfig)
ActiveRecord::Base.logger = Logger.new(STDOUT)    

#migrations
class CreateAllTables < ActiveRecord::Migration
  def self.up
    create_table(:contracts) do |t|
      t.string :name
      t.integer :status
    end
  end
end

RSpec.configure do |config|
  config.before :all do
    CreateAllTables.up unless ActiveRecord::Base.connection.table_exists? 'contracts'
  end
end