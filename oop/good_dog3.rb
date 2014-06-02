require 'pry'

class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  @@number_of_dogs = 0

  def initialize(n, a)
    self.name = n
    self.age = a * DOG_YEARS
    @@number_of_dogs += 1
  end

  def self.total_number_of_dogs
    @@number_of_dogs
  end

  def to_s
    "This dog's name is #{name} and it is #{age} in dog years."
  end
end

puts GoodDog.total_number_of_dogs

spot = GoodDog.new('spot', 3)
fritz = GoodDog.new('fritz', 8)

puts "#{spot.name} is #{spot.age} years old in dog years"
puts "#{fritz.name} is #{fritz.age} years old in dog years"
puts "There are #{GoodDog.total_number_of_dogs} dogs in total"

puts spot
puts fritz

#binding.pry

