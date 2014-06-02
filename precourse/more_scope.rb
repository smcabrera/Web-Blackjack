x = 1
puts x
def inc
  x += 1
end

puts x

def mutate_method(x)
  x += 1
  return x
end

puts "after mutate_method #{x}"
