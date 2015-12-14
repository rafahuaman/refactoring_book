class Movie
  attr_accessor :price_code
  attr_reader :title
  CHILDRENS = 2 
  REGULAR = 0 
  NEW_RELEASE = 1

  def initialize(title, price_code)
    @title = title
    @price_code = price_code
  end
end

class Rental
  attr_reader :days_rented, :movie
  def initialize(movie, days_rented)
    @movie = movie
    @days_rented = days_rented
  end
  
  def get_charge
    result = 0.0
    case movie.price_code
    when Movie::REGULAR
      result+=2
      if days_rented > 2
        result += (days_rented - 2)*1.5
      end
    when Movie::NEW_RELEASE
      result += days_rented*3
    when Movie::CHILDRENS
      result+=1.5
      if days_rented > 3
        result+= (days_rented - 3)*1.5
      end
    end
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
    total_amount = 0.0
    frequent_renter_points = 0
    rentals = @rentals.each
    result = "Rental Record for #{@name}\n"
    while(rentals.count > 0)
      begin
        each = rentals.next
      rescue StopIteration
        break
      end

      each.get_charge

      #add frequent renter points
      frequent_renter_points +=1
      #add bonues for a two day new release rental
      if (each.movie.price_code == Movie::NEW_RELEASE && each.days_rented > 1)
        frequent_renter_points+=1
      end

      #show figures for this rental
      result+= "\t#{each.movie.title}\t#{each.get_charge.to_s}\n"
      total_amount+= each.get_charge
    end
    #add footer lines
    result += "Amount owed is #{total_amount.to_s}\n"
    result += "You earned #{frequent_renter_points.to_s} frequent renter points"
    result
  end
end
