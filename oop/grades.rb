class Student
  attr_accessor :name

  def initialize(name, grade)
    @grade = grade
    @name = name
  end

  def better_grade_than?(opponent)
    self.grade > opponent.grade
  end

  protected

  def grade
    @grade
  end
end

bob = Student.new("Bob", 190)
joe = Student.new("Joe", 100)
puts "Well done!" if joe.better_grade_than?(bob)
