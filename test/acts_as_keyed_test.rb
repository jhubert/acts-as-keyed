require_relative 'test_helper'

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

  test "should generate a key based on a set of characters in the chars option" do
    character_set = %w(a b c)
    owk_setup(:chars => %w(a b c))

    o = ObjectWithKey.create
    assert_contains_only character_set, o.key
  end

  test "should generate key based on size parameter" do
    owk_setup(:size => 2)

    o = ObjectWithKey.create
    assert_equal 2, o.key.length
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

    assert_raise ActsAsKeyed::NoAvailableKeysError do
      2.times do
        o = ObjectWithKey.create
      end
    end
  end

  test "should use a different column if specified as a string" do
    ObjectWithoutKey.acts_as_keyed(:column => 'name')

    o = ObjectWithoutKey.create()
    assert_not_nil o.name
  end

  test "should use a different column if specified as a symbol" do
    ObjectWithoutKey.acts_as_keyed(:column => :name)

    o = ObjectWithoutKey.create()
    assert_not_nil o.name
  end

  test "should fail if object doesn't have key column" do
    output = nil

    assert_raise ActsAsKeyed::MissingKeyColumnError do
      ObjectWithoutKey.acts_as_keyed
    end
  end

  private

  def owk_setup(options = {})
    ObjectWithKey.acts_as_keyed(options)
  end

  def assert_contains_only(expected_characters, actual_string, message=nil)
    assert actual_string =~ Regexp.new("^[#{expected_characters.join}]+$"), "#{actual_string} contains more than just '#{expected_characters.join}'"
  end
end
