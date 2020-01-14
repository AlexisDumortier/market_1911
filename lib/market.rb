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
    @vendors.map { |vendor| vendor.name}
  end

  def vendors_that_sell(item)
    @vendors.find_all { |vendor| vendor.inventory.include? item}
  end

  def item_list
    @vendors.reduce([]) do |result, vendor| 
      item_in_stock = vendor.inventory.find_all { |item, quantity| quantity != 0 }
      result << item_in_stock.map {|item| item[0].name}
    end.flatten.uniq
  end

  def sorted_item_list
    item_list.sort_by {|item| item}
  end

  def total_inventory
    @vendors.reduce(Hash.new(0)) do |result, vendor|
      vendor.inventory.each { |item, quantity| result[item] += quantity}
      result
    end
  end

  def sell(item, quantity)
    if (total_inventory[item] >= quantity)
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