begin
  puts "Parsed #{Integer('1000')}."

  puts "Parsed #{Integer('A grand')}." # 'A grand'.to_i would return nil
rescue ArgumentError => e
  puts "Error: #{e}."
ensure
  puts "Have a nice day."
end
