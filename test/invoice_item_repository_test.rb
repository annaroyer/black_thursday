require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test
  def setup
    @invoices = mock('invoicerepository')
    @invoice_items = InvoiceItemRepository.new(@invoices)
    file_path = './test/fixtures/invoice_items_truncated.csv'
    @invoice_items.from_csv(file_path)
  end

  def test_it_returns_all_known_invoice_items
    invoices = @invoice_items.all

    assert_equal 10, invoices.length
    assert invoices.all? do |invoice|
      invoice.class = InvoiceItem
    end
  end

  def test_it_can_find_an_invoice_item_by_id
    invoice = @invoice_items.find_by_id(2778)

    assert_instance_of InvoiceItem, invoice
    assert_equal 2778, invoice.id
  end

  def test_find_by_id_returns_nil_if_no_invoice_with_id
    assert_nil @invoice_items.find_by_id(5)
  end

  def test_it_can_find_all_by_item_id
    invoices = @invoice_items.find_all_by_item_id(263395617)

    assert_equal 3, invoices.length
    assert invoices.all? do |invoice|
      invoice.item_id == 263395617 && invoice.class == Invoice
    end
  end

  def test_it_returns_an_empty_array_if_no_invoices_with_item_id
    invoices = @invoice_items.find_all_by_item_id(2633)

    assert invoices.empty?
  end

  def test_it_finds_all_by_invoice_id
    invoices = @invoice_items.find_all_by_invoice_id(4)

    assert_equal 4, invoices.length
    assert invoices.all? do |invoice|
      invoice.invoice_id == 1635 && invoice.class == Invoice
    end
  end

  def test_it_finds_all_by_invoice_id_returns_an_empty_array_if_no_invoices_with_invoice_id
    invoices = @invoice_items.find_all_by_invoice_id(678)

    assert invoices.empty?
  end
end