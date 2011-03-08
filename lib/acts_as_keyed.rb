module ActsAsKeyed
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def acts_as_keyed(options={})
      class_inheritable_accessor :options
      options[:size] ||= 10
      options[:chars] ||= ('a'..'z').to_a + ('A'..'Z').to_a + (1..9).to_a - ['l','I','O']
      self.options = options

      raise ArgumentError, "#{self.name} is missing key column" if columns_hash['key'].nil?

      before_validation_on_create :create_key

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

  module InstanceMethods

    def to_param
      options[:as_param] ? self.key : self.id.to_s
    end

    def regenerate_key!
      self.create_key
      self.save
    end

    protected

    def create_key
      k = random_key
      while(self.class.count(:conditions => { :key => k }) > 0)
        k = random_key
      end
      self.key = k
    end

    def random_key
      code_array=[]
      1.upto(options[:size]) { code_array << options[:chars][rand(options[:chars].length)] }
      code_array.to_s
    end
  end
end

ActiveRecord::Base.send :include, ActsAsKeyed