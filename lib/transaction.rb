class Transaction
  @@id = 1
  def initialize(customer, product)
    @id = @@id
    @customer = customer
    @product = product

    @@id += 1
    decrease_product_stock(@product)
  end

  def id
    @id
  end

  def decrease_product_stock(item)
    raise OutOfStockError, "'#{item.title}' is out of stock" if item.stock === 0
    item.stock -= 1
  end

  def product
    @product
  end

  def customer
    @customer
  end

  def self.all
    all_transactions = []
    ObjectSpace.each_object(Transaction) do |trans_obj|
      all_transactions << trans_obj
    end
    all_transactions
  end

  def self.find(id)
    Transaction.all.each do |trans_obj|
      return trans_obj if trans_obj.id == id
    end
  end


end