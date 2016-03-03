class Product

  def initialize(options = {})
    validates_title_uniqueness(options.fetch(:title))
    @title = options.fetch(:title)
    @price = options.fetch(:price)
    @stock = options.fetch(:stock)

  end

  def title
    @title
  end

  def price
    @price
  end

  def stock
    @stock
  end

  def stock=(num)
    @stock = num
  end

  def in_stock?
    self.stock > 0 ? true : false
  end

  def self.all
    all_products = []
    ObjectSpace.each_object(Product) do |obj|
      all_products << obj
    end
    all_products
  end

  def self.find_by_title(title)
    Product.all.each do |product_obj|
      return product_obj if product_obj.title == title
    end
  end

  def self.in_stock
    products_in_stock = []
    ObjectSpace.each_object(Product) do |obj|
      products_in_stock << obj if obj.in_stock?
    end
    products_in_stock
  end

  def self.purchases_by_item
    purchases = {}
    Product.all.each do |product_obj|
      purchases[product_obj.title] = product_obj.number_sold
    end
    purchases
  end

  def validates_title_uniqueness(title)
    Product.all.each do |existing_product|
      raise DuplicateProductError, "#{title} already exists." if existing_product.title == title
    end
    true
  end

  def number_sold
    num_sold = 0
    Transaction.all.each do |transaction_obj|
      num_sold += 1 if transaction_obj.product == self
    end
    num_sold
  end

end