require 'spec_helper'
require 'video_store'
require 'rspec/given'

describe Customer do
  Given(:valid_attributes) {{ name: 'John' }}
  context 'when creating a new customer' do
    When(:customer) { Customer.new(valid_attributes[:name]) }
    Then { expect(customer.name).to eq valid_attributes[:name] }
  end

  describe 'GoldenMaster' do
    it 'records a golden master' do
      movie_1= Movie.new('title 1', Movie::CHILDRENS)
      movie_2= Movie.new('title 2', Movie::NEW_RELEASE)
      movie_3= Movie.new('title 3', Movie::REGULAR)
      rental_1 = Rental.new(movie_1, 4)
      rental_2 = Rental.new(movie_2, 2)
      rental_3 = Rental.new(movie_3, 3)
      customer = Customer.new('John')
      customer.add_rental(rental_1)
      customer.add_rental(rental_2)
      customer.add_rental(rental_3)
      result = customer.statement
      golden_master = File.open('golden_master.txt', 'r')
      gm_contents = golden_master.read
      expect(result).to eq gm_contents
    end
  end
end

describe Movie do
  Given(:valid_attributes) {{title: 'The Terminator', price_code: Movie::REGULAR}}
  context 'when creating a new movie' do
    When(:movie) { Movie.new(valid_attributes[:title], valid_attributes[:price_code]) } 
    Then { expect(movie.title).to eq valid_attributes[:title] }
    And  { expect(movie.price_code).to eq valid_attributes[:price_code] }
  end
end

describe Rental do
  Given(:movie) {double('movie')}
  Given(:valid_attributes) {{movie: movie, days_rented: 1}}
  context 'when creating a new Rental record' do
    When(:rental) { Rental.new(valid_attributes[:movie], valid_attributes[:days_rented]) }
    Then { expect(rental.movie).to be movie }
    And  { expect(rental.days_rented).to eq valid_attributes[:days_rented] }
  end
end
