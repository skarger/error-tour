def a; b; end

def b; c; end

def c; raise "c you in hell"; end

begin
  puts "Calling method_a..."
  a
rescue => e
  # what should this handling code do?
  puts "Error: #{e}"
ensure
  puts "Have a nice day."
end

