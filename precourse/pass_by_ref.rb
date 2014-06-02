def some_method(obj) 
  obj.uniq
end

outer_obj = [1, 2, 2, 3, 3]
some_method(outer_obj)

puts outer_obj

# Test this and it doesn't seem to have changed the outer object
# Seems like ruby then is pass by value, rather than by pass by reference

puts "Looks like the inner object was mutated by the outer object wasn't"



def some_method(obj) 
  obj.uniq!
end

outer_obj = [1, 2, 2, 3, 3]
some_method(outer_obj)

puts outer_obj

puts "Now the outerobject is mutated as well because we used the destructive uniq! with a bang"
puts ""

 
