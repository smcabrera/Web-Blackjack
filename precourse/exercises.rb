my_array = [1,2,3,4,5,6,7,8,9,10]

# # multi-line version
# my_array.each do |number|
#   puts number
# end

# # one line version

# my_array.each { |number| puts number }

# puts "#2 Only print out values greater than 5"

# my_array.each do |number|
#   if number > 5
#     puts number
#   end  
# end

# my_array.each { |number| puts number if number > 5}

# new_array = my_array.select { |number| number % 2 == 1}
# puts new_array 

# new_array = my_array.select do |number|
#   number % 2 != 0
# end 

# puts new_array

# puts "Append 11 and prepend 0 to the array"


my_array.push 11
# or 
# my_array << 11

#prepend

my_array.unshift(0)

puts my_array 
puts "Get rid of 11 and add a 3"

my_array.pop()
puts my_array
my_array.push 3
puts my_array







