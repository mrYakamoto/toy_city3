class Transaction
  attr_reader :customer, :product, :id

  @@id = 1
  @@all_transactions = []

  def initialize(customer, product)
    @id = @@id
    @customer = customer
    @product = product

    @@id += 1
    @@all_transactions << self
    decrease_product_stock(@product)
  end

  def decrease_product_stock(item)
    item.stock -= 1
  end

  def self.all
    @@all_transactions
  end

  def self.find(id)
    @@all_transactions[id - 1]
  end


end