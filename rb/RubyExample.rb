begin
  puts "Parsed #{Integer('1000')}."
  puts "Parsed #{Integer('A grand')}."
rescue ArgumentError => e
  puts "Error: #{e}."
ensure
  puts "Have a nice day."
end
