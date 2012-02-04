module ActsAsKeyed
  class NoAvailableKeys < StandardError
    def to_s
      'Very few unique keys are still available. Please change your acts_as_keyed chars or size settings.'
    end
  end
end