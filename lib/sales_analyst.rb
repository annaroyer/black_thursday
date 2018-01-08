require 'bigdecimal'

class SalesAnalyst
  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def merchants
    @sales_engine.merchants.all
  end

  def items
    @sales_engine.items.all
  end

  def average_items_per_merchant
    (items.count.to_f / merchants.count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    average_item_count = average_items_per_merchant
    Math.sqrt(
      merchants.reduce(0) do |sum, merchant|
        sum + (merchant.items.count - average_item_count)**2
      end / (merchants.count - 1)
    ).round(2)
  end

  def one_standard_deviation_above_average
    average_items_per_merchant + average_items_per_merchant_standard_deviation
  end

  def merchants_with_high_item_count
    high_item_count = one_standard_deviation_above_average
    merchants.find_all do |merchant|
      merchant.items.count > high_item_count
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = @sales_engine.find_merchant_by_merchant_id(merchant_id)
    return merchant.average_item_price
  end

  def average_average_price_per_merchant
    sum_averages = merchants.reduce(0) do |total, merchant|
      total + merchant.average_item_price
    end
    return (sum_averages / merchants.count).round(2)
  end

  def average_price_per_merchant_standard_deviation
    all_merchant_average = average_average_price_per_merchant
    Math.sqrt(
      items.reduce(0) do |sum, item|
        sum + (item.unit_price - all_merchant_average)**2
      end / (items.count - 1)
    ).round(2)
  end

  def two_standard_deviations_above_average_price
    two_standard_deviations = average_price_per_merchant_standard_deviation * 2
    return average_average_price_per_merchant + two_standard_deviations
  end

  def golden_items
    golden_price_floor = two_standard_deviations_above_average_price
    items.find_all do |item|
      item.unit_price > golden_price_floor
    end
  end
end
