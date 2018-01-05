require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test
  def setup
    file_path = './test/fixtures/invoice_items_truncated.csv'
    @ir = InvoiceItemRepository.new(file_path)
  end

  def test_it_returns_all_known_invoice_items
    invoices = @ir.all

    assert_equal 16, invoices.length
    assert invoices.all? do |invoice|
      invoice.class = InvoiceItem
    end
  end
end

# all - returns an array of all known InvoiceItem instances
# find_by_id - returns either nil or an instance of InvoiceItem with a matching ID
# find_all_by_item_id - returns either [] or one or more matches which have a matching item ID
# find_all_by_invoice_id - returns either [] or one or more matches which have a matching invoice ID
