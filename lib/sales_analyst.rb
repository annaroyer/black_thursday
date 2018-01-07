require 'bigdecimal'

class SalesAnalyst
  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def merchants
    @sales_engine.merchants.all
  end

  # def total_items
  #  merchants.reduce(0) do |total, merchant|
  #    total + merchant.item_count
  #  end
  # end

  def total_items
    @sales_engine.item_count
  end

  def average_items_per_merchant
    (total_items.to_f / merchants.count).round(2)
  end

  def sum_squared_differences_from_average
    merchants.reduce(0) do |sum, merchant|
      sum + ((merchant.item_count - average_items_per_merchant)**2)
    end
  end

  def average_items_per_merchant_standard_deviation
    Math.sqrt((sum_squared_differences_from_average) / (total_items - 1))
  end

  def one_standard_deviation_above_average
    average_items_per_merchant + average_items_per_merchant_standard_deviation
  end

  def merchants_with_high_item_count
    merchants.find_all do |merchant|
      merchant.item_count > one_standard_deviation_above_average
    end
  end
end
