module ActsAsKeyed
  module ClassMethods
    def acts_as_keyed(options={})
      before_validation :create_key, :on => :create
      class_attribute :options

      options[:as_param] ||= false
      options[:column] ||= 'key'
      options[:size] ||= 10
      options[:chars] ||= ('a'..'z').to_a + ('A'..'Z').to_a + (1..9).to_a - ['l','I','O']

      self.options = options

      options[:column] = options[:column].to_s

      raise MissingKeyColumnError if ActiveRecord::Base.connection.table_exists?(self.table_name) && columns_hash[options[:column]].nil?

      class << self
        def find(*args)
          if self.options[:as_param] && args.first.is_a?(String)
            send("find_by_#{options[:column]}", args)
          else
            super(*args)
          end
        end

        def key_exists?(k)
          exists?(["#{options[:column]} = ?", k])
        end

        def generate_key(size = nil)
          size ||= options[:size]

          code_array=[]
          1.upto(options[:size]) { code_array << options[:chars][rand(options[:chars].length)] }
          code_array.join('')
        end
      end

      include InstanceMethods
    end
  end
end
