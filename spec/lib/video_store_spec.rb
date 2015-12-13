require 'spec_helper'
require 'video_store'
require 'rspec/given'

describe Customer do
  it 'creates a customer' do
    expect(Customer.new('Mike')).to be_a(Customer)
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
