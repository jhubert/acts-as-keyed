require 'rubygems'
require 'test/unit'
require 'active_support'
require 'active_record'
require 'active_model'

$:.unshift "#{File.dirname(__FILE__)}/../"
$:.unshift "#{File.dirname(__FILE__)}/../lib/"

require 'acts_as_keyed'

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

ActiveRecord::Schema.define(:version => 1) do
  create_table :objects_with_key_column do |t|
    t.string    :key
  end

  create_table :objects_without_key_column do |t|
    t.string    :name
  end
end

def teardown_db
  ActiveRecord::Base.connection.tables.each do |table|
    ActiveRecord::Base.connection.drop_table(table)
  end
end

class ObjectWithKey < ActiveRecord::Base
  self.table_name = 'objects_with_key_column'
end

class ObjectWithoutKey < ActiveRecord::Base
  self.table_name = 'objects_without_key_column'
end
