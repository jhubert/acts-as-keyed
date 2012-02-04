module ActsAsKeyed
  class NoAvailableKeysError < StandardError
    def to_s
      'Very few unique keys are still available. Please change your acts_as_keyed chars or size settings.'
    end
  end
  class MissingKeyColumnError < StandardError
    def to_s
      'The table must have a column named "key"'
    end
  end
end