require 'spec_helper'
require 'video_store'

describe Customer do
  it 'creates a customer' do
    expect(Customer.new('Mike')).to be_a(Customer)
  end
  
end
