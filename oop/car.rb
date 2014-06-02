class Vehicle
  @@number_of_vehicles = 0

  def initialize(year, color, model)
    @current_speed = 0
    @year = year
    @color = color
    @model = model
    @@number_of_vehicles += 1
  end

  def self.gas_mileage(gallons, miles)
    puts "#{miles/gallons} miles per gallon"
  end

  def accelerate(number)
    @current_speed += number
    puts "You push the gas and accelerate #{number} mph."
  end

  def brake(number)
    @current_speed -= (number)
    puts "You push the brake and decelerate #{number} mph."
  end

  def current_speed
    puts "You are now going #{@current_speed} mph."
  end

  def shut_off
    @current_speed = 0
    puts "Let's park this bad boy!"
  end

  def self.total_number_of_vehicles
    @@number_of_vehicles
  end

  def display_age
    puts "This vehicle is #{age} years old"
  end

  private

  def age
    this_year = Time.now.to_a[5]
    this_year - self.year
  end
end

class MyCar < Vehicle
  attr_reader :year, :model
  attr_accessor :color

  DOORS = 4

  def to_s
    puts "This car is a #{self.year} #{self.color} #{self.model}"
  end

  def paint(color)
    self.color = color
    puts "painting the car #{color}"
  end
end

module Towable
  def tow(weight)
    puts "This vehicle can tow #{weight} tons."
  end
end

class MyTruck < Vehicle
  attr_reader :year, :model
  attr_accessor :color

  include Towable
  DOORS = 2
  def to_s
    puts "This truck is a #{self.year} #{self.color} #{self.model}"
  end

  def paint(color)
    self.color = color
    puts "painting the truck #{color}"
  end
end


corrolla = MyCar.new(2001, "silver", "corrolla")
ford = MyTruck.new(1981, "Ford", "F-150")
puts corrolla
puts

puts "I've got #{Vehicle.total_number_of_vehicles} vehicles total."
ford.tow(16)

puts "---Method lookup for trucks---"
puts MyTruck.ancestors
puts "---Method lookup for cars---"
puts MyCar.ancestors
puts "---Method lookup for Vehicle---"
puts Vehicle.ancestors
puts ford.display_age
