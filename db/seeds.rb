# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


ColourScheme.create(
	background:  "rgb(4,27,38)", 
	font:    "rgb(238,247,251)", 
	highlight: "rgb(33,99,131)",
)

ColourScheme.create(
	background:  "rgb(118,17,28)", 
	font:      "rgb(255,251,247)", 
	highlight: "rgb(210,157,158)",
)

ColourScheme.create(
	background:   "rgb(12,68,29)", 
	font:      "rgb(249,255,247)", 
	highlight: "rgb(192,229,180)",
)
