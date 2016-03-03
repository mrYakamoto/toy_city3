class Customer
  @@all_customers = []

  def initialize(options = {})
    validates_name_uniqueness(options.fetch(:name))
    @name = options.fetch(:name)
    @@all_customers << self
  end

  def name
    @name
  end

  def purchase(product)
    raise OutOfStockError, "'#{product.title}' is out of stock" if product.stock === 0
    Transaction.new(self, product)
  end

  def purchase_history
    buyer_history = Hash.new(0)
    Transaction.all.each do |trans_obj|
      if (trans_obj.customer == self)
        buyer_history[trans_obj.product.title] += 1
      end
    end
    buyer_history
  end

  def self.all
    @@all_customers
  end

  def self.find_by_name(name)
    @@all_customers.each do |customer|
      return customer if customer.name == name
    end
  end

  def validates_name_uniqueness(name)
    @@all_customers.each do |existing_customer|
      raise DuplicateCustomerError, "'#{name}' already exists" if existing_customer.name == name
    end
    true
  end

end