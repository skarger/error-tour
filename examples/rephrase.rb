def normalize_email(email_address)
  email_address.downcase
rescue => e
  raise e, "Could not normalize email address '#{email_address.inspect}': #{e.message}"
end
