class Product

  def initialize(options = {})
    @title = options.fetch(:title)
    @price = options.fetch(:price)
    @stock = options.fetch(:stock)

    Product.all.each do |title|
      raise DuplicateProductError, "#{@title} already exists." if title == @title
    end
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
end




