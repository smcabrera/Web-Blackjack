class Person
  #Won't let you change the name like we want below
  #attr_reader :name
  attr_accessor :name #Will let you change the name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
bob.name = "Bob"
puts bob.name
