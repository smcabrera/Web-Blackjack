
class GoodDog
  def initialize(n, h, w)
    @name = n
    @height = h
    @weight = w
  end

  attr_accessor :name, :height, :weight

  #These two methods are equivalent to the one that precedes them
  #def get_name
  #  @name
  #end

  #def set_name=(name)
  #  @name = name
  #end

  def speak
    "#{name} says arf!"
  end

  def change_info(n, h, w)
    self.name = n
    self.height = h
    self.weight = w
  end

  def info
    "#{name} weighs #{weight} and is #{height} tall."
  end
end

puts "using the change_info method we just added"
sparky = GoodDog.new('Sparky', '12 inches', '10 lbs')
puts sparky.info

sparky.change_info('Spartacus', '24 inches', '45 lbs')
puts sparky.info


