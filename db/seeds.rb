# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(	login: 'test',
										email: 'test@example.com',
										password: 'foobar',
										password_confirmation: 'foobar',
										description: 'lorem ipsum',
										activated: true,
										activated_at: Time.zone.now)

admin = User.create( login: 'admin',
										email: 'admin@example.com',
										password: 'foobar',
										password_confirmation: 'foobar',
										description: 'lorem ipsum',
										admin: true,
										activated: true,
										activated_at: Time.zone.now)

99.times do |n|
	login = Faker::Internet.user_name
	email = "example#{n+1}@example.com"
	password = Faker::Internet.password(6)
	description = Faker::Lorem.paragraph

	user = User.create(	login: login,
											email: email,
											password: password,
											password_confirmation: password,
											description: description,
											activated: true,
											activated_at: Time.zone.now)
end

