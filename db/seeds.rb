puts ' *** Setting up default user login and roles ***'

puts 'ROLES'
YAML.load(ENV['ROLES']).each do |role|
  Role.find_or_create_by_name("role")
  puts 'role: ' << role
end

puts 'GENERATING WHITELIST'
Whitelist.create!(email: ENV['ADMIN_EMAIL'].dup)

puts 'DEFAULT USERS'
user = User.create!(email: ENV['ADMIN_EMAIL'].dup, name: ENV['ADMIN_NAME'].dup
                    password: ENV['ADMIN_PASSWORD'].dup, password_confirmation: ENV['ADMIN_PASSWORD'].dup)
user.confirm!
puts 'user: ' << user.email
user.add_role :admin
