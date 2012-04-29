module ActsAsKeyed
  module InstanceMethods

    def to_param
      options[:as_param] ? self.key : self.id.to_s
    end

    def regenerate_key!
      self.create_key
      self.save
    end

    def key=(val)
      write_attribute(options[:column], val)
    end

    def key
      read_attribute(options[:column])
    end

    protected

    def create_key
      k = nil
      100.times do
        k = self.class.generate_key
        break if !self.class.key_exists?(k)
        k = nil
      end
      raise NoAvailableKeysError if k.nil?
      self.key = k
    end
  end
end