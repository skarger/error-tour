begin
  puts "try 1: parsed #{Integer('1000')}"
  puts "try 2: parsed #{Integer('A grand')}"
rescue ArgumentError => e
  puts "rescue: #{e}"
ensure
  puts "ensure: Have a nice day."
end
