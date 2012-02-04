require 'test/test_helper'

class ActsAsKeyedBaseTest < ActiveSupport::TestCase
  def setup
  end

  def teardown
  end
end

class ActsAsKeyedTest < ActsAsKeyedBaseTest
  test "should generate key on create" do
    owk_setup

    o = ObjectWithKey.create()
    assert_not_nil o.key
  end

  test "should generate key based on custom characters" do
    owk_setup(:chars => ['a'])

    o = ObjectWithKey.create
    assert_equal 'aaaaaaaaaa', o.key
  end

  test "should generate key based on size parameter" do
    owk_setup(:size => 2)

    o = ObjectWithKey.create
    assert_equal 2, o.key.length
  end

  test "should treat key as a protected attribute" do
    owk_setup

    o = ObjectWithKey.create
    o.update_attributes(:key => 'hello')
    assert_not_equal 'hello', o.key
  end

  test "should require a unique key" do
    owk_setup(:chars => (0...10).to_a, :size => 1)

    sum = 0
    10.times do
      o = ObjectWithKey.create
      sum += o.key.to_i
    end

    assert_equal 45, sum
  end

  test "should raise an error if no unique keys can be found easily" do
    owk_setup(:chars => ['a'], :size => 1)

    error = false
    begin
      2.times do
        o = ObjectWithKey.create
      end
    rescue ActsAsKeyed::NoAvailableKeys
      error = true
    end

    assert error
  end

  test "should fail if object doesn't have key column" do
    output = nil
    begin
      ObjectWithoutKey.acts_as_keyed
    rescue ArgumentError => e
      output = e.message
    end
    assert_equal "ObjectWithoutKey is missing key column", output
  end

  private

  def owk_setup(options = {})
    ObjectWithKey.acts_as_keyed(options)
  end
end