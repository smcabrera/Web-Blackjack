# OOP in Ruby
# 1. classes and objects
# 2. classes contain behaviors

class Dog
  attr_accessor :name, :height, :weight

  @@count = 0

  def self.total_dogs
    "Total number of dogs: #{@@count}"
  end

  def euthanize!
    puts "#{name}: AHHHH!"
    @@count = @@count - 1
  end

  def initialize(n, h, w)
    @name = n
    @height = h
    @weight = w
    @@count += 1
  end

  def speak
    "#{@name} barks!"
  end

  def info
    "#{@name} is #{@height} feet tall and weights #{@weight} pounds"
  end

  def update_info(n, h, w)
    self.name = n
    self.height = h
    self.weight = w
  end
end

teddy = Dog.new('teddy', 3, 95)
fido = Dog.new('fido', 1, 35)

puts teddy.speak
puts fido.speak

puts fido.info
teddy.update_info('Roosevelt', 5, 95)
