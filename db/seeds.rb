# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

instruments = [
  "Piano",
  "Guitar",
  "Voice",
  "Violin",
  "Flute",
  "Saxophone",
  "Theory"
]

instruments.each do |instrument|
  Instrument.create( name: instrument)
end

rooms = [
  ["Vivace", "Main"],
  ["Allegro", "Room Left"],
  ["Presto", "Room Right"],
  ["Crescendo", "Apartment"],
  ["Symphony", "Office"],
  ["Concert", "Up Stairs"],
  ["Ensemble", "Kitchen"],
  ["Off-Site", "Off-Site"]
]

rooms.each do |room|
  Room.create( name: room[0], location: room[1])
end

teachers = [
  ["Francisco", "Renteria", "renteriav@hotmail.com", "9085 N. Sweet Acacia Pl", "Tucson", "AZ", "85742", "5204042918", "Cell"],
  ["W. Mark", "Akin", "gibson610@yahoo.com", "721 N. Olsen Ave", "Tucson", "AZ", "85719", "7317801491", "Home"],
  ["Elizabeth", "Bunt", "elizbunt@yahoo.com", "715 E. Lee St #18", "Tucson", "AZ", "85719", "5202356546", "Home"]
]

teachers.each do |teacher|
  Teacher.create(
      first: teacher[0],
      last: teacher[1],
      email: teacher[2],
      addresses_attributes: [
        street: teacher[3],
        city: teacher[4],
        state: teacher[5],
        zip: teacher[6],
        preferred_addresses_attributes: [
          description: "mailing"
        ]
      ],
      telephones_attributes: [
        number: teacher[7],
        description: teacher[8]
      ]
    )
end

