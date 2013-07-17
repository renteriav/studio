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
  "Theory"
]

instruments.each do |instrument|
  Instrument.create( name: instrument)
end

rooms = [
  ["Symphony", "main"],
  ["Ensemble", "kitchen"],
  ["Allegro", "living room"],
  ["Vivace", "office"],
  ["Presto", "room left"],
  ["Andante", "room right"],
  ["Crescendo", "upstairs"],
  ["Off Site", "off site"]
]

rooms.each do |room|
  Room.create( name: room[0], location: room[1])
end

teachers = [
  ["Francisco", "Renteria", "renteriav@hotmail.com", "9085 N. Sweet Acacia Pl", "Tucson", "AZ", "85742", "5204042918", "Cell"],
  ["Jose", "Perez", "perez@hotmail.com", "2345 N. Calle Rica", "Tucson", "AZ", "85743", "5201423456", "Cell"],
  ["Ying", "Zung", "Zung@hotmail.com", "2546 S. Calle Otra", "Tucson", "AZ", "85764", "5203567878", "Cell"]
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

