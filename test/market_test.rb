# pry(main)> market.add_vendor(vendor1)    

# pry(main)> market.add_vendor(vendor2)    

# pry(main)> market.add_vendor(vendor3)

# pry(main)> market.vendors
# #=> [#<Vendor:0x00007fe1348a1160...>, #<Vendor:0x00007fe1349bed40...>, #<Vendor:0x00007fe134910650...>]

# pry(main)> market.vendor_names
# #=> ['Rocky Mountain Fresh', 'Ba-Nom-a-Nom', "Palisade Peach Shack"]

# pry(main)> market.vendors_that_sell(item1)
# #=> [#<Vendor:0x00007fe1348a1160...>, #<Vendor:0x00007fe134910650...>]

# pry(main)> market.vendors_that_sell(item4)
#=> [#<Vendor:0x00007fe1349bed40...>]

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/vendor'
require_relative '../lib/item'
require_relative '../lib/market'


class MarketTest < Minitest::Test 

  def test_it_exists
    market = Market.new('South Pearl Street Farmers Market') 
    assert_instance_of Market, market 
  end

  def test_it_has_attributes
    market = Market.new('South Pearl Street Farmers Market') 
    assert_equal 'South Pearl Street Farmers Market', market.name
    assert_equal [], market.vendors
  end

  def test_it_can_add_vendors
    market = Market.new('South Pearl Street Farmers Market') 
    
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: '$0.50'})
    item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})

    vendor1 = Vendor.new("Rocky Mountain Fresh")
    vendor1.stock(item1, 35)
    vendor1.stock(item2, 7)

    vendor2 = Vendor.new("Ba-Nom-a-Nom")
    vendor2.stock(item4, 50)
    vendor2.stock(item3, 25)

    vendor3 = Vendor.new("Palisade Peach Shack")
    vendor3.stock(item1, 65)

    market.add_vendor(vendor1)
    market.add_vendor(vendor2)
    market.add_vendor(vendor3)

    assert_equal [vendor1, vendor2, vendor3], market.vendors  
  end

  def test_it_can_list_the_name_of_the_vendors
    market = Market.new('South Pearl Street Farmers Market') 

    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: '$0.50'})
    item3 = Item.new({name: 'Peach-Raspberry Nice Cream', price: '$5.30'})
    item4 = Item.new({name: 'Banana Nice Cream', price: '$4.25'})

    vendor1 = Vendor.new('Rocky Mountain Fresh')
    vendor1.stock(item1, 35)
    vendor1.stock(item2, 7)

    vendor2 = Vendor.new('Ba-Nom-a-Nom')
    vendor2.stock(item4, 50)
    vendor2.stock(item3, 25)

    vendor3 = Vendor.new('Palisade Peach Shack')
    vendor3.stock(item1, 65)

    market.add_vendor(vendor1)
    market.add_vendor(vendor2)
    market.add_vendor(vendor3)
    expected = ['Rocky Mountain Fresh', 'Ba-Nom-a-Nom', 'Palisade Peach Shack']
    assert_equal expected, market.vendor_names
  end

  def test_it_can_list_the_vendors_that_sell_a_particular_item
    market = Market.new('South Pearl Street Farmers Market') 
    
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: '$0.50'})
    item3 = Item.new({name: 'Peach-Raspberry Nice Cream', price: '$5.30'})
    item4 = Item.new({name: 'Banana Nice Cream', price: '$4.25'})
    item5 = Item.new({name: 'Jackfruit', price: '$1.25'})
    
    vendor1 = Vendor.new('Rocky Mountain Fresh')
    vendor1.stock(item1, 35)
    vendor1.stock(item2, 7)

    vendor2 = Vendor.new('Ba-Nom-a-Nom')
    vendor2.stock(item4, 50)
    vendor2.stock(item3, 25)

    vendor3 = Vendor.new('Palisade Peach Shack')
    vendor3.stock(item1, 65)

    market.add_vendor(vendor1)
    market.add_vendor(vendor2)
    market.add_vendor(vendor3)

    assert_equal [vendor1, vendor3], market.vendors_that_sell(item1)
    assert_equal [vendor2], market.vendors_that_sell(item4)
    assert_equal [], market.vendors_that_sell(item5)
  end

  def test_it_can_return_a_list_all_items_in_stock_on_the_market
    market = Market.new('South Pearl Street Farmers Market') 
    
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: '$0.50'})
    item3 = Item.new({name: 'Peach-Raspberry Nice Cream', price: '$5.30'})
    item4 = Item.new({name: 'Banana Nice Cream', price: '$4.25'})
    item5 = Item.new({name: 'Jackfruit', price: '$1.25'})
    
    vendor1 = Vendor.new('Rocky Mountain Fresh')
    vendor1.stock(item1, 35)
    vendor1.stock(item2, 7)

    vendor2 = Vendor.new('Ba-Nom-a-Nom')
    vendor2.stock(item4, 50)
    vendor2.stock(item3, 25)

    vendor3 = Vendor.new('Palisade Peach Shack')
    vendor3.stock(item1, 65)

    market.add_vendor(vendor1)
    market.add_vendor(vendor2)
    market.add_vendor(vendor3)
    expected = ["Peach", "Tomato", "Banana Nice Cream", "Peach-Raspberry Nice Cream"]
    assert_equal expected, market.item_list
  end

  def test_it_can_return_a_list_all_items_in_stock_on_the_market
    market = Market.new('South Pearl Street Farmers Market') 
    
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: '$0.50'})
    item3 = Item.new({name: 'Peach-Raspberry Nice Cream', price: '$5.30'})
    item4 = Item.new({name: 'Banana Nice Cream', price: '$4.25'})
    item5 = Item.new({name: 'Jackfruit', price: '$1.25'})
    
    vendor1 = Vendor.new('Rocky Mountain Fresh')
    vendor1.stock(item1, 35)
    vendor1.stock(item2, 7)

    vendor2 = Vendor.new('Ba-Nom-a-Nom')
    vendor2.stock(item4, 50)
    vendor2.stock(item3, 25)

    vendor3 = Vendor.new('Palisade Peach Shack')
    vendor3.stock(item1, 65)

    market.add_vendor(vendor1)
    market.add_vendor(vendor2)
    market.add_vendor(vendor3)
    expected = ["Banana Nice Cream", "Peach", "Peach-Raspberry Nice Cream", "Tomato"]
    assert_equal expected, market.sorted_item_list
  end

   def test_it_can_return_a_list_all_items_in_stock_on_the_market
    market = Market.new('South Pearl Street Farmers Market') 
    
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: '$0.50'})
    item3 = Item.new({name: 'Peach-Raspberry Nice Cream', price: '$5.30'})
    item4 = Item.new({name: 'Banana Nice Cream', price: '$4.25'})
    item5 = Item.new({name: 'Jackfruit', price: '$1.25'})
    
    vendor1 = Vendor.new('Rocky Mountain Fresh')
    vendor1.stock(item1, 35)
    vendor1.stock(item2, 7)

    vendor2 = Vendor.new('Ba-Nom-a-Nom')
    vendor2.stock(item4, 50)
    vendor2.stock(item3, 25)

    vendor3 = Vendor.new('Palisade Peach Shack')
    vendor3.stock(item1, 65)

    market.add_vendor(vendor1)
    market.add_vendor(vendor2)
    market.add_vendor(vendor3)
    expected = ['Banana Nice Cream', 'Peach', 'Peach-Raspberry Nice Cream', 'Tomato']

    expected = {item1 => 100, item2 => 7, item3 => 25, item4 => 50}
    assert_equal expected, market.total_inventory
  end

  def test_it_can_reduce_the_stock_for_a_given_item_and_quantity

    market = Market.new('South Pearl Street Farmers Market') 
    
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: '$0.50'})
    item3 = Item.new({name: 'Peach-Raspberry Nice Cream', price: '$5.30'})
    item4 = Item.new({name: 'Banana Nice Cream', price: '$4.25'})
    item5 = Item.new({name: 'Onion', price: '$0.25'})
    
    vendor1 = Vendor.new('Rocky Mountain Fresh')
    vendor1.stock(item1, 35)
    vendor1.stock(item2, 7)

    vendor2 = Vendor.new('Ba-Nom-a-Nom')
    vendor2.stock(item4, 50)
    vendor2.stock(item3, 25)

    vendor3 = Vendor.new('Palisade Peach Shack')
    vendor3.stock(item1, 65)

    market.add_vendor(vendor1)
    market.add_vendor(vendor2)
    market.add_vendor(vendor3)
    
    market.reduce_stock(item4, 5)
    assert_equal 45,vendor2.check_stock(item4)

    market.reduce_stock(item1, 50)
    assert_equal 0,vendor1.check_stock(item1)
    assert_equal 50,vendor3.check_stock(item1)
  end

  def test_it_can_sell_items

    market = Market.new('South Pearl Street Farmers Market') 
    
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: '$0.50'})
    item3 = Item.new({name: 'Peach-Raspberry Nice Cream', price: '$5.30'})
    item4 = Item.new({name: 'Banana Nice Cream', price: '$4.25'})
    item5 = Item.new({name: 'Onion', price: '$0.25'})
    
    vendor1 = Vendor.new('Rocky Mountain Fresh')
    vendor1.stock(item1, 35)
    vendor1.stock(item2, 7)

    vendor2 = Vendor.new('Ba-Nom-a-Nom')
    vendor2.stock(item4, 50)
    vendor2.stock(item3, 25)

    vendor3 = Vendor.new('Palisade Peach Shack')
    vendor3.stock(item1, 65)

    market.add_vendor(vendor1)
    market.add_vendor(vendor2)
    market.add_vendor(vendor3)
    
    assert_equal false, market.sell(item1, 200)
    assert_equal false, market.sell(item5, 1)
    assert_equal true, market.sell(item4, 5)
    assert_equal 45,vendor2.check_stock(item4)

    market.sell(item1, 40)
    assert_equal 0, vendor1.check_stock(item1)
    assert_equal 60, vendor3.check_stock(item1)
  end



end