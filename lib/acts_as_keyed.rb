Copyright (c) 2012 Jeremy Hubert

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

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

      if Rails.version < '3'
        before_validation_on_create :create_key
      else
        before_validation :create_key, :on => :create
      end

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
      code_array.join('')
    end
  end
end

ActiveRecord::Base.send :include, ActsAsKeyed