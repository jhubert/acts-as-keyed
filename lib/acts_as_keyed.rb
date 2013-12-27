require 'active_record'
require 'protected_attributes'
require 'acts_as_keyed/errors'
require 'acts_as_keyed/class_methods'
require 'acts_as_keyed/instance_methods'

module ActsAsKeyed
  def self.included(base)
    base.extend ClassMethods
  end
end

ActiveRecord::Base.send :include, ActsAsKeyed