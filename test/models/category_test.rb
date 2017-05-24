require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  def setup
    @category = Category.new(name: "sports")
  end

  test "category should be valid" do
    assert @category.valid?
  end

  test "name should be present" do
    @category.name =" "
    assert_not @category.valid?
  end

  test "name should unique" do
    @category.save
    category2 = Category.new(name: "sports")
    assert_not category2.valid?
  end

  test "not maximum then 20 characters" do
    @category.name = "a" * 26
    assert_not @category.valid?
  end
  
  test "name should not too short" do
    @category.name = "aa"
    assert_not @category.valid?
  end
end
