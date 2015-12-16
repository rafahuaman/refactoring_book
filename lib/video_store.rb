class Movie
  attr_reader :title
  CHILDRENS = 2 
  REGULAR = 0 
  NEW_RELEASE = 1

  def initialize(title, price_code)
    @title = title
    set_price_code(price_code)
  end
  
  def get_charge(days_rented)
    @price.get_charge(days_rented)
  end

  def price_code
    @price.get_price_code 
  end

  def set_price_code(price_code)
    case price_code
    when Movie::REGULAR
      @price = RegularPrice.new
    when Movie::NEW_RELEASE
      @price = NewReleasePrice.new
    when Movie::CHILDRENS
      @price = ChildrensPrice.new
    else
      raise ArgumentError
    end
  end

  def get_frequent_renter_points(days_rented)
    @price.get_frequent_renter_points(days_rented)
  end
end

class Price
  def get_price_code
  end
  
  def get_charge(days_rented)
  end
  
  def get_frequent_renter_points(days_rented)
    1
  end
end

class ChildrensPrice < Price
  def get_price_code
    Movie::CHILDRENS
  end
  
  def get_charge(days_rented)
    result = 1.5
    if days_rented > 3
      result+= (days_rented - 3)*1.5
    end
  end
end

class NewReleasePrice < Price
  def get_price_code
    Movie::NEW_RELEASE
  end
  
  def get_charge(days_rented)
    result = days_rented*3.0
  end

  def get_frequent_renter_points(days_rented)
    if days_rented > 1
      2
    else
      1
    end
  end
end

class RegularPrice < Price
  def get_price_code
    Movie::REGULAR
  end
  
  def get_charge(days_rented)
    result = 2.0
    if days_rented > 2
      result += (days_rented - 2)*1.5
    end
  end
end

class Rental
  attr_reader :days_rented, :movie
  def initialize(movie, days_rented)
    @movie = movie
    @days_rented = days_rented
  end

  def get_charge
    movie.get_charge(days_rented)
  end

  def get_frequent_renter_points
    movie.get_frequent_renter_points(days_rented)
  end
end

class Customer
  attr_reader :name
  def initialize(name)
    @name = name
    @rentals = []
  end

  def add_rental(rental)
    @rentals << rental
  end

  def statement
    rentals = @rentals.each
    result = "Rental Record for #{@name}\n"
    while(rentals.count > 0)
      begin
        each = rentals.next
      rescue StopIteration
        break
      end

      #show figures for this rental
      result+= "\t#{each.movie.title}\t#{each.get_charge.to_s}\n"
    end
    #add footer lines
    result += "Amount owed is #{get_total_charge.to_s}\n"
    result += "You earned #{get_total_frequent_renter_points.to_s} frequent renter points"
    result
  end

  def get_total_charge
    result = 0.0
    rentals = @rentals.each
    while(rentals.count > 0)
      begin
        each = rentals.next
      rescue StopIteration
        break
      end
      result += each.get_charge
    end
    result 
  end

  def get_total_frequent_renter_points
    result = 0
    rentals = @rentals.each
    while(rentals.count > 0)
      begin
        each = rentals.next
      rescue StopIteration
        break
      end
      result += each.get_frequent_renter_points
    end
    result 
  end
end
