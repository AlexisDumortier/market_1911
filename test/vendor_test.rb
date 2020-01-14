

# vendor.check_stock(item1)
# #=> 0

# vendor.stock(item1, 30)

# vendor.inventory
# #=> {#<Item:0x007f9c56740d48...> => 30}

# vendor.check_stock(item1)
# #=> 30

# vendor.stock(item1, 25)

# vendor.check_stock(item1)
# #=> 55

# vendor.stock(item2, 12)

# vendor.inventory

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/vendor'
require_relative '../lib/item'

class VendorTest < Minitest::Test 

  def test_it_exists
    vendor = Vendor.new('Rocky Mountain Fresh')
    assert_instance_of Vendor, vendor 
  end

  def test_it_has_attributes
    vendor = Vendor.new('Rocky Mountain Fresh')
    assert_equal 'Rocky Mountain Fresh', vendor.name
    assert_equal ({}), vendor.inventory
  end

  def test_it_can_check_stock_for_a_given_item
    vendor = Vendor.new('Rocky Mountain Fresh')
    item = Item.new({name: 'Tomato', price: '$0.50'})
    assert_equal 0, vendor.check_stock(item)
  end

  def test_it_can_stock_an_item 
    vendor = Vendor.new('Rocky Mountain Fresh')
    item1 = Item.new({name: 'Tomato', price: '$0.50'})
    vendor.stock(item1, 30)
    assert_equal ({item1 => 30}), vendor.inventory
    assert_equal 30, vendor.check_stock(item1)

    vendor.stock(item1, 25)
    assert_equal ({item1 => 55}), vendor.inventory

    item2 = Item.new({name: 'Peach', price: "$0.75"})
    vendor.stock(item2, 15)
    assert_equal ({ item1 => 55, item2 => 15 }), vendor.inventory
  end

end
