
number = 2637
thousands = number / 1000
hundreds = number % 1000 / 100
tens = number % 100 / 10
ones = number % 10
puts number
puts "thousands place: " + thousands.to_s
puts "hundreds place: " + hundreds.to_s
puts "tens place: " + tens.to_s
puts "ones place: " + ones.to_s

