# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.create!( :name => "Conf" )
Category.create!( :name => "Meeting" )
Category.create!( :name => "Kaigi" )

Group.create!( :name => "Ruby" )
Group.create!( :name => "JavaScript" )
Group.create!( :name => "Java" )