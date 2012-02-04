module ActsAsKeyed
  module ClassMethods
    def acts_as_keyed(options={})
      before_validation :create_key, :on => :create
      class_attribute :options

      options[:as_param] ||= false
      options[:size] ||= 10
      options[:chars] ||= ('a'..'z').to_a + ('A'..'Z').to_a + (1..9).to_a - ['l','I','O']

      self.options = options

      raise ArgumentError, "#{self.name} is missing key column" if ActiveRecord::Base.connection.table_exists?(self.table_name) && columns_hash['key'].nil?

      attr_protected :key

      class << self
        def find(*args)
          if self.options[:as_param] && args.first.is_a?(String)
            find_by_key(args)
          else
            super(*args)
          end
        end
      end
    
      include InstanceMethods
    end
  end
end