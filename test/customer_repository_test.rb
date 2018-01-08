require_relative 'test_helper'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test
  def setup
    @cr = CustomerRepository.new
    @cr.from_csv('./test/fixtures/customers_truncated.csv')
  end

  def test_all_returns_all_known_customers
    customers = @cr.all

    assert_equal 8, customers.length
    assert customers.all? do |customer|
      customer.class == Customer
    end
  end

  def test_it_can_find_a_customer_by_id
    customer = @cr.find_by_id(1)

    assert_equal 1, customer.id
    assert_instance_of Customer, customer
  end

  def test__find_by_id_returns_nil_if_no_customer_has_id
    assert_nil @cr.find_by_id(22)
  end

  def test_find_all_by_first_name_finds_all_customers_with_given_fragment_in_first_name
    fragment = "ann"
    customers = @cr.find_all_by_first_name(fragment)

    assert_equal 3, customers.length
    assert customers.all? do |customer|
      customer.first_name.downcase.include?(first_name.downcase)
    end
  end

  def test_find_all_by_first_name_returns_empty_array_when_no_customers_name_matches_given_fragment
    first_name = "Lou"
    customers = @cr.find_all_by_first_name(first_name)

    assert customers.empty?
  end

  def test_find_all_by_last_name_finds_all_customers_with_given_fragment_in_last_name
    fragment = "toy"
    customers = @cr.find_all_by_last_name(fragment)

    assert_equal 2, customers.length
    assert customers.all? do |customer|
    customer.last_name.downcase.include?(last_name.downcase)
    end
  end

  def test_find_all_by_last_name_returns_empty_array_when_no_customers_name_matches_given_fragment
    last_name = "Johns"
    customers = @cr.find_all_by_last_name(last_name)

    assert customers.empty?
  end
end
