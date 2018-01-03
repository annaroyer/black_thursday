require './test/test_helper'
require './lib/merchant'

class MerchantTest < Minitest::Test
  def test_it_has_id
    m = Merchant.new({:id => 5, :name => "Turing School"}, mock('SalesEngine'))

    assert_equal 5, m.id
  end

  def test_it_has_name
    m = Merchant.new({:id => 5, :name => "Turing School"}, mock('SalesEngine'))

    assert_equal "Turing School", m.name
  end

  def test_items_returns_an_array_of_all_merchants_items
    m = Merchant.new({:id => 5, :name => "Turing School"}, mock('SalesEngine'))

    result = m.items

    assert result.all? do |item|
      item.merchant_id == m.id
    end
  end
end
