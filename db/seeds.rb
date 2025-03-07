# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Create a default user for development
if Rails.env.development? || Rails.env.test?
  user = User.find_or_create_by(username: 'admin')
  user.update(password: 'password')
end
