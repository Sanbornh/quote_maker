# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


LayoutScheme.create(layout_parameters: {
	font: "Cardo-Regular",
	font_size: 60,
	quote_marks: true,
	col: 80
})

LayoutScheme.create(layout_parameters: {
	font: "OpenSans-Bold",
	font_size: 150,
	underline: true,
	col: 20
})