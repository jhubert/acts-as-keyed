module ActsAsKeyed
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
      k = nil
      100.times do
        k = random_key
        break if self.class.count(:conditions => { :key => k }) == 0
        k = nil
      end
      raise NoAvailableKeys if k.nil?
      self.key = k
    end

    def random_key
      code_array=[]
      1.upto(options[:size]) { code_array << options[:chars][rand(options[:chars].length)] }
      code_array.join('')
    end
  end
end