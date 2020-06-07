Product = Struct.new(:id)

product = Product.new(123)

class ProductUpdateError < StandardError
  attr_reader :product_id

  def initialize(product_id)
    @product_id = product_id
  end
end

def update_product(product)
  # code that updates product...
  raise 'some unexpected bug'
rescue
  raise ProductUpdateError.new(product.id)
end

begin
  update_product(product)
rescue ProductUpdateError => e
  puts "Exception: #{e}, Product ID: #{e.product_id}"
  puts "Cause: #{e.cause.inspect}"
  puts e.cause.backtrace.join("\n")
end
