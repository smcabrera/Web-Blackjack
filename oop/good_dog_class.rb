module Swimmable
  def swim
    "I'm swimming!"
  end
end

class Animal
  def speak
    "Hello!"
  end
end

class Fish < Animal
  include Swimmable
end

class Mammal < Animal
end

class GoodDog < Mammal
  include Swimmable
  attr_accessor :name

  def initialize(n)
    self.name = n
  end

  def speak
    "#{self.name} says arf!"
  end
end

class Cat < Animal
end

sparky = GoodDog.new("Sparky")
paws = Cat.new
puts sparky.speak
puts paws.speak

neemo = Fish.new

sparky.swim
neemo.swim
#paws.swim --paws the cat can't swim so this would return an error
