count = 0
while count < 10
  puts count
  count += 1
end

puts "trying something else. What if it calls a method each time\n\n"

def count_end(count)
  if count == 8
    return true
  else
    return false
  end
end

until count_end(count)
  puts count
end
