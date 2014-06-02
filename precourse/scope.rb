a = 5

3.times do
  a = 3
  b = 5
end 

puts a
# puts b

a = 5

def some_method
  a = 3
end

puts a

puts "But what if I call some_method? Does that reset it?"
puts some_method()




