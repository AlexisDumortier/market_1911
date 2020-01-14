class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map(&:name)
  end

  def vendors_that_sell(item)
    @vendors.find_all { |vendor| vendor.inventory.include? item }
  end

  def item_list
    @vendors.reduce([]) do |result, vendor|
      item_in_stock = vendor.inventory.find_all { |_item, quantity| quantity != 0 }
      result << item_in_stock.map { |item, _quantity| item.name }
    end.flatten.uniq
  end

  def sorted_item_list
    item_list.sort
  end

  def total_inventory
    @vendors.each_with_object(Hash.new(0)) do |vendor, result|
      vendor.inventory.each { |item, quantity| result[item] += quantity }
    end
  end

  def sell(item, quantity)
    if total_inventory[item] >= quantity
      reduce_stock(item, quantity)
      true
    else
      false
    end
  end

  def reduce_stock(item, quantity)
    quantity_sold = 0
    vendors_that_sell(item).each do |vendor|
      if vendor.inventory[item] > quantity - quantity_sold
        vendor.inventory[item] -= quantity - quantity_sold
        break
      else
        quantity_sold += vendor.inventory[item]
        vendor.inventory[item] = 0
      end
    end
  end
end
