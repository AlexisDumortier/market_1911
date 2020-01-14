# item2 = Item.new({name: 'Tomato', price: '$0.50'})
# #=> #<Item:0x007f9c565c0ce8...>

# item2.name
# #=> "Tomato"

# item2.price
# #=> "$0.50"

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item'

class ItemTest < Minitest::Test 

  def test_it_exists
    item = Item.new({name: 'Tomato', price: '$0.50'})
    assert_instance_of Item, item 
  end

  def test_it_has_attributes
    item = Item.new({name: 'Tomato', price: '$0.50'})
    assert_equal 'Tomato', item.name 
    assert_equal '$0.50', item.price
  end
end