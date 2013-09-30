# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


u= User.new
u.first_name = "Admin"
u.last_name = "Manager"
u.email = "admin@example.com"
u.password = "admin123"
u.save
if u.present?
 	p = u.permissions.new
 	p.action = "manage"
	p.actions_list = ["all"]
 	p.save
end