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
  ["Jessica", "Carnevale", "shh-quietly@hotmail.com", "r", "6134 E. Rosewood", "Tucson", "AZ", "85711", ["Piano", "Theory"], "5203600121", "Cell"],
  ["Kyungsun", "Choi", "kyungsun@email.arizona.edu", "r", "7785 E. Elk Creek Rd.", "Tucson", "AZ", "85750", ["Piano"], "5206644719", "Home"],
  ["Daniela", "Gonzales", "danielag1@email.arizona.edu", "r", "1355 W. Rogers Rd. Apt. 12248", "Tucson", "AZ", "85705",["Saxophone", "Theory"],  "5203132335", "Home"],
  ["Kathryn", "Harpainter", "kharpainter@hotmail.com", "r", "1130 E. Linden St.", "Tucson", "AZ", "85719", ["Violin"], "5303681988", "Home"],
  ["Callie", "Hutchinson", "calliehutch@gmail.com", "r", "2625 E. Cooper St. # 1", "Tucson", "AZ", "85716", ["Violin"], "6512353599", "Cell"],
  ["Kate", "Nichols", "nicholselsakate@email.arizona.edu", "r", "1601 N. Oracle Rd", "Tucson", "AZ", "85705", ["Flute"], "3525522396", "Cell"],
  ["Joo Young", "Oh", "jyo75@email.arizona.edu", "r", "6795 E. Calle La Paz # 5205", "Tucson", "AZ", "85715", ["Piano", "Theory"], "5204817667", "Home"],
  ["Hyeyeon", "Park", "hyeyeon1025@gmail.com", "r", "2963 E. 24th St.", "Tucson", "AZ", "85713", ["Piano"], "5202222737", "Home"],
  ["Sangjoon", "Park", "park3@email.arizona.edu", "r", "5755 E. River Rd. # 2311", "Tucson", "AZ", "85750", ["Piano"], "5204447454", "Cell"],
  ["Francisco", "Renteria", "renteriav@hotmail.com", "r", "9085 N. Sweet Acacia Pl", "Tucson", "AZ", "85742", ["Piano"], "5204042918", "Cell"],
  ["Rebekah", "Sharpton", "resharp@email.arizona.edu", "r", "5615 S. Forrest Ave.", "Tucson", "AZ", "85746", ["Voice"], "5203348887", "Cell"],
  ["Cecilia", "Whitby", "cewhitby@aol.com", "r", "5257 N. Coronado Pl.", "Tucson", "AZ", "85750", ["Piano"], "5204403035", "Home"],
  ["Mark", "Wilson", "markwilson86@gmail.com", "r", "1060 S. Desert Senna Loop", "Tucson", "AZ", "85748", ["Guitar"], "5209905872", "Home"],
  ["W. Mark", "Akin", "gibson610@yahoo.com", "s", "721 N. Olsen Ave.", "Tucson", "AZ", "85719", ["Guitar"], "7317801491", "Home"],
  ["Elizabeth", "Bunt", "elizbunt@yahoo.com", "r", "715 E. Lee St. #18", "Tucson", "AZ", "85719", ["Saxophone"], "5202356546", "Home"]
]

teachers.each do |teacher|
  @instruments = Array.new
  teacher[8].each do |instrument|
    @instruments = @instruments.push(Instrument.where("name = ?", instrument).first.id)
  end
  Teacher.create(
      first: teacher[0],
      last: teacher[1],
      email: teacher[2],
      status: teacher[3],
      addresses_attributes: [
        street: teacher[4],
        city: teacher[5],
        state: teacher[6],
        zip: teacher[7],
        preferred_addresses_attributes: [
          description: "mailing"
        ]
      ],
      telephones_attributes: [
        number: teacher[9],
        description: teacher[10]
      ],
      instrument_ids: @instruments  
    )
end

customers = [
  ["Adair", "Craig", 
    [
      [5203969627, "Home"],
      [5209758977, "Fax"]
    ], 
      "craigandkym@yahoo.com",
    [
      ["Grace", "Adair"]
    ]
  ],
  ["Ames", "Richard",  
    [
      [5206385869, "Home"],
      [5202098274, "Mr. cell"],
      [5402203578, "Mrs. Cell"]
    ], 
    "annaanes@msn.com",
    [
      ["Will", "Ames"],
      ["Gabriella", "Ames"]
    ]
  ],
  ["Andrade/Brydle", "Raymond", 
    [
      [5205848957, "Home"],
      [5202715647, "Mrs. work"],
      [5202711852, "Mr. Cell"]
    ], 
    "kimray@dakotacom.net",
    [
      ["Samantha", "Andrade"]
    ]
  ],
  ["Anton", "Erik", 
    [
      [6237606096, "Mr. cell"]
    ], 
    "antonfive@me.com",
    [
      ["Morgan", "Anton"]
    ]
  ],
  ["Artz", "Katie", 
    [
      [5207849160, "Mrs. cell"],
      [5204445561, "Alt."]
    ], 
    "ksartz@yahoo.com",
    [
      
    ]
  ],
  ["Bartholomew/Mendoza", "Lourdes", 
    [
      [5206386450, "Home"],
      [5202046146, "Mrs. cell"]
    ], 
    "lourdesmenla@hotmail.com",
    [
      ["Stephanie", "Bartholomew"]
    ]
  ], 
  ["Bernstein/Belakovskala", "Lawrence", 
    [
      [5203700700, "Home"]
    ],
    "angelina@gmail.com",
    [
      
    ]
  ],
  ["Beskind", "Dan", 
    [
      [5205772007, "Home"]
    ],
    "vickibeskind@comcast.net", 
    [
      ["Julia", "Beskind"]
    ]
  ],
  ["Bhola", "Khush", 
    [
      [5205775139, "Home"]
    ],
    "ka3bhola@comcast.net",
    [
      ["Mason", "Bhola"],
      ["Lily", "Bhola"]
    ]
  ],
  ["Biggs/Blackman", "Laura", 
    [
      [5202411199, "Mr. cell"]
    ],
    "",
    [
      ["Chloe", "Biggs"],
      ["Ben", "Biggs"]
    ]
  ],
  ["Bogan", "Ben", 
    [
      [5208860249, "Home"]
    ],
    "boganfour@q.com",
    [
      ["Emma", "Bogan"],
      ["Gabby", "Bogan"]
    ]
  ],
  ["Bryant", "Jeffrey", 
    [
      [5207310389, "Home"]
    ],
    "terrydiefenbach@yahoo.com",
    [
      ["Chloe", "Bryant"]
    ]
  ],
  ["Burrows", "Peter", 
    [
      [5205295567, "Home"]
    ], 
    "jennburrows@comcast.net",
    [
      ["Max", "Burrows"]
    ]
  ],
  ["Caputo", "Anthony", 
    [
      [5205749262, "Home"]
    ], 
    "jankiandanthony@comcast.net", 
    [
      ["Meena", "Caputo"],
      ["Arjun", "Caputo"]
    ]
  ],
  ["Chan", "Chris", 
    [
      [5205291768, "Home"]
    ], 
    "isheen19@hotmail.com",
    [
      ["Abby", "Chan"]
    ]
  ],
  ["Chandra", "Rajesh", 
    [
      [5205770721, "Home"]
    ], 
    "gigs64@yahoo.com", 
    [
      ["Swati", "Chandra"],
      ["Sumeet", "Chandra"]
    ]
  ],
  ["Chavez/Pirson", "Arturo", 
    [
      [5205293677, "Home"]
    ], 
    "cagdech@comcast.net",
    [
      ["Georges", "Chavez"],
      ["Arturo", "Chavez"]
    ]
  ],
  ["Conant", "William", 
    [
      [5207221699, "Home"]
    ], 
    "bnk87@comcast.net",
    [
      ["Ryan", "Conant"],
      ["Erin", "Conant"]
    ]
  ],
  ["Connolly/Bae", "Michael", 
    [
      [5207494700, "Home"]
    ], 
    "sbaedo@yahoo.com",
    [
      ["Megan", "Connolly"],
      ["Erin", "Connolly"]
    ]
  ],
  ["Crossett", "Jason", 
    [
      [5205483899, "Mr. cell"]
    ], 
    "bcrossett26@gmail.com",
    [
      ["Anna", "Crossett"]
    ]
  ],
  ["Darling", "Chris", 
    [
      [5202909777, "Home"]
    ], 
    "katejeremiah@hotmail.com",
    [
      ["Elizabeth", "Darling"]
    ]
  ],
  ["Dasika", "Kalyan", 
    [
      [5205297138, "Home"]
    ], "rksdasika@gmail.com",
    [
      ["Sahasrakshi", "Dasika"],
      ["Ru", "Dasika"]
    ]
  ],
  ["Dasse", "Dan", 
    [
      [5202070460, "Home"], 
      [5613527542, "Mr. cell"]
    ], 
    "judydasse@gmail.com",
    [
      ["Clementine", "Dasse"]
    ]
  ],
  ["DiPonio", "Joseph", 
    [
      [5206388187, "Mr. cell"]
    ], 
    "diponios@gmail.com",
    [
      ["Isabella", "DiPonio"],
      ["Sophia", "DiPonio"]
    ]
  ],
  ["Donatelli", "Geoff", 
    [
      [5205771859, "Home"]
    ], "oh2serve@aol.com",
    [
      
    ]
  ],
  ["Dorame", "Mano", 
    [
      [5208707814, "Home"]
    ], 
    "mjdmjd02@gmail.com",
    [
      
    ]
  ],
  ["Egami", "Elichi", 
    [
      [5206150342, "Home"]
    ], 
    "michiyo.egami@gmail.com",
    [
      ["Toshi", "Egami"],
      ["Aki", "Egami"],
      ["Michiyo", "Egami"]
    ]
  ],
  ["Esquerra/Windoor", "Marisela", 
    [
      [5207337129, "Home"]
    ], 
    "sgtwindoor@aol.com",
    [
      ["Sebastian", "Esquerra"]
    ]
  ],
  ["Fan/Kim.Xiaohui", "Xiaohui", 
    [
      [5202996219, "Home"]
    ], 
    "serena@as.arizona.edu",
    [
      ["Felix", "Fan"]
    ]
  ],
  ["Favre","Johnathan", 
    [
      [5204375331, "Home"]
    ], 
    "favrejon2714@msn.com",
    [
      
    ]
  ],
  ["Fell", "Tony", 
    [
      [7704101953, "Home"]
    ], 
    "christine.fell@gmail.com",
    [
      ["Sophie","Fell"],
      ["Jude", "Fell"]
    ]
  ],
  ["Garcia", "Frank", 
    [
      [5202992866, "Home"]
    ], 
    "garcia-kathy@persistech.com",
    [
      ["Jenna", "Garcia"]
    ]
  ],
  ["Ghosh", "Mrinal", 
    [
      [5205443052, "Home"]
    ], 
    "sujatasarkar1@gmail.com",
    [
      ["Rohini", "Ghosh"],
      ["Bhargav", "Ghosh"],
      ["Aditi", "Ghosh"]
    ]
  ],
  ["Givens", "Kevin", 
    [
      [5205770092, "Home"]
    ], "calebkevin@msn.com",
    [
      ["Calen", "Givens"]
    ]
  ],
  ["Gupta", "Ajay", 
    [
      [5206151789, "Home"]
    ], 
    "priyagupta@yahoo.com",
    [
      ["Divva", "Gupta"]
    ]
  ],
  ["Hagedon", "Brian", 
    [
      [5203278054, "Home"]
    ], 
    "katiegirl57@cox.net",
    [
      ["Christian", "Hagedon"]
    ]
  ],
  ["Haile", "Darren", 
    [
      [3187945230, "Mr. cell"]
    ], 
    "prayedup365@gmail.com",
    [
      
    ]
  ],
  ["Harlow", "Brian", 
    [
      [5205290675, "Home"]
    ], 
    "jill_tucson@yahoo.com",
    [
      
    ]
  ],
  ["Harris", "Tim", 
    [
      [5205778568, "Home"]
    ], 
    "tjeaharris@comcast.net",
    [
      ["Emma", "Harris"]
    ]
  ],
  ["Haynes", "Sean", 
    [
      [9284860165, "Mr. cell"]
    ], 
    "wynell_haynes@hotmail.com",
    [
      ["Joshua", "Haynes"]
    ]
  ],
  ["Hellbusch", "Jeffrey", 
    [
      [526159585, "Home"]
    ], 
    "jhelbus@yahoo.com",
    [
      ["Ethan", "Hellbush"],
      ["Dylan", "Hellbush"]
    ]
  ],
  ["Hogan", "Suzanne", 
    [
      [5205770261, "Home"]
    ], 
    "suzannehogan@yahoo.com",
    [
      
    ]
  ],
  ["Houge", "David", 
    [
      [5202962043, "Mr. work"]
    ], 
    "dhouge@q.com",
    [
      
    ]
  ],
  ["Hudson/Altoubal", "Riad", 
    [
      [5208917171, "Mrs. cell"]
    ], 
    "lhudson@email.arizona.edu",
    [
      ["Zayna", "Altoubal"]
    ]
  ],
  ["Hugeback", "David", 
    [
      [5202965668, "Home"]
    ], 
    "dahuge@msn.com",
    [
      ["Laura", "Hugeback"]
    ]
  ]  
]


customers.each do |customer|
  Customer.create(
    first: customer[1],
    last: customer[0],
    email: customer[3]
  )
  customer[4].each do |student|
    @customer = Customer.where("email = ?", customer[3]).first
    Student.create(
        first: student[0],
        last: student[1],
        customer_id: @customer.id
    )
  end
  customer[2].each do |telephone|
    @customer = Customer.where("email = ?", customer[3]).first
    Customer.update(@customer.id,
    telephones_attributes: [
        number: telephone[0],
        description: telephone[1]
      ]
    )
  end 
end