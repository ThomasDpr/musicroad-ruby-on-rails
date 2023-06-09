puts 'Cleaning database...'
FestivalsArtist.destroy_all
City.destroy_all
Artist.destroy_all
Festival.destroy_all
User.destroy_all


def create_festival(name, location, description, start_date, image_path, end_date, url, artist_names)
  puts "Creating festival: #{name}..."
  festival = Festival.create!(
    name: name,
    location: location,
    description: description,
    start_date: start_date,
    end_date: end_date,
    url: url
  )

  # file = File.open(Rails.root.join(photo_path))
  # festival.photo.attach(io: file, filename: 'festival.jpg', content_type: 'image/jpg')
  # festival.save!


  puts "#{name} created !"

  puts "Creating artists for #{name}..."

  artist_names.each do |artist_name|
    artist = Artist.find_or_create_by(name: artist_name)
    FestivalsArtist.create!(festival: festival, artist: artist)
  end
  puts "#{name} artists created !"

  City.all.each do |city|
    create_chatroom(festival: festival, city: city)
  end

  festival
end

def create_user(first_name, last_name, age, email, password, photo_path)
  puts "Creating user: #{first_name} #{last_name}..."

  user = User.create!(
    first_name: first_name,
    last_name: last_name,
    age: age,
    email: email,
    password: password
  )

  file = File.open(Rails.root.join(photo_path))
  user.photo.attach(io: file, filename: 'avatar.jpg', content_type: 'image/jpg')
  user.save!

  puts "#{first_name} #{last_name} created !"
end

def create_city(name)
  puts "Creating city: #{name}..."

  city = City.create!(
    name: name
  )

  puts "#{name} created !"
  city
end

def create_chatroom(festival:, city:)
  name = "#{festival.name} - #{city.name}"
  chatroom = Chatroom.create(festival: festival, city: city, name: name)
end

cities = [
  'Paris', 'Marseille', 'Lyon', 'Toulouse', 'Nice', 'Nantes', 'Strasbourg', 'Bordeaux', 'Lille',
  'Brest'
]
paris = City.create!(name: "Paris")
lyon = City.create(name: "Lyon")
toulouse = City.create(name: "Toulouse")
nice = City.create(name: "Nice")
nantes = City.create(name: "Nantes")
strasbourg = City.create(name: "Strasbourg")
bordeaux = City.create(name: "Bordeaux")
lille = City.create(name: "Lille")

#cities.each do |city|
  ## city
#end

create_user(
  'Drink',
  'Jagger',
  "27",
  'drink-jagger@gmail.com',
  'musicroad',
  'db/avatar/drink_jagger.jpg'
)

create_user(
  'Pouris',
  'Hilton',
  "25",
  'pouris-hilton@gmail.com',
  'musicroad',
  'db/avatar/pouris_hilton.jpg'
)

create_user(
  'Muncha',
  'Kunis',
  "32",
  'muncha-kunis@gmail.com',
  'musicroad',
  'db/avatar/muncha_kunis.jpg'
)

create_user(
  'Jeff',
  'Golum',
  "45",
  'jeff-golum@gmail.com',
  'musicroad',
  'db/avatar/jeff_golum.jpg'
)

create_user(
  'Scoop',
  'Dogg',
  '25',
  'scoop-dogg@gmail.com',
  'musicroad',
  'db/avatar/scoop_dogg.jpg'
)

create_user(
  'Leonardo',
  'DiCarpaccio',
  '25',
  'leonardo-dicarpaccio@gmail.com',
  'musicroad',
  'db/avatar/leonardo_dicarpaccio.jpg'
)

create_user(
  'Chef',
  'Bezos',
  '25',
  'chef-bezos@gmail.com',
  'musicroad',
  'db/avatar/chef_bezos.jpg'
)

create_user(
  'Elon',
  'Trust',
  '25',
  'elon-trust@gmail.com',
  'musicroad',
  'db/avatar/elon_trust.jpg'
)

create_user(
  'John',
  'McDonald',
  '25',
  'john-mcdonaldd@gmail.com',
  'musicroad',
  'db/avatar/john_mcdonald.jpg'
)

create_user(
  'Leona',
  'Helmsworth',
  '25',
  'leona-helmsworth@gmail.com',
  'musicroad',
  'db/avatar/leona_helmsworth.jpg'
)

create_user(
  'Seyfried',
  'Gonzalez',
  '25',
  'seyfried-gonzalez@gmail.com',
  'musicroad',
  'db/avatar/seyfried_gonzalez.jpg'
)

musicalarue = create_festival(
  'Musicalarue',
  'Luxey (40)',
  'Musicalarue est un festival de musique qui se déroule chaque année à Luxey',
  Date.new(2023, 7, 28 ),
  'db/images_festivals/festival-1.jpg',
  Date.new(2023, 7, 30 ),
  'https://www.musicalarue.com/',
  [
    'ODEZENNE', 'BIGA RANX', 'JAIN', 'HUBERT FELIX THIEFAINE - Replugged', 'WAX TAILOR', 'MARC LAVOINE',
    'BCUC (Bantu Continua Uhuru Consciousness)', 'SILMARILS', 'EMILIE SIMON', 'OUAI STEPHANE', 'LABESS',
    'ANA TIJOUX', 'GRAYSSOKER', 'SIMONY', 'ANGLE MORT & CLIGNOTANT', 'THE LITTLE SADIES BAND', 'HYL',
    'MICHEL POLNAREFF', 'LA FEMME', 'MATMATAH', 'CALI', 'MASSILIA SOUND SYSTEM', 'LA CARAVANE PASSE',
    'HILIGHT TRIBE', 'MEZERG', 'LITTLE BIG', 'TINARIWEN', 'UZI FREYJA', 'SWIFT GUAD', 'THE HYENES',
    'DALLE BETON', "AL'TARBA", 'ANGELA', 'PROLETER', 'THIS WILL DESTROY YOUR EARS', 'DEMAIN RAPIDES',
    'LE JOSEM', 'CXK', '-M- (MATTHIEU CHEDID)', 'DELUXE', 'LA P\'TITE FUMEE', 'BENJAMIN BIOLAY',
    'MEUTE', 'HK', 'BAGARRE', 'ASTEREOTYPIE', 'ROLAND CRISTAL', 'MEULE', 'MANUDIGITAL', 'HANIA RANI',
    'AL TARBA', 'MOUNIKA', 'WATI WATIA ZOREY BAND DE MORIARTY', 'ALMÄ MANGO', 'MARGUERITE THIAM',
    'PVC QUE DU TUBE'
  ]
)

file = File.open(Rails.root.join("db/images_festivals/festival-1.jpg"))
musicalarue.photo.attach(io: file, filename: "festival.jpg", content_type: "image/jpeg")
musicalarue.save!

retro_c_trop = create_festival(
  'Retro C Trop',
  'Chateau De Tilloloy, 80700 Tilloloy',
  "Retro mais toujours dans le vent, ces groupes et artistes qui ont déjà 20, 30, 40 ou même 50 ans de carrière. Alors si vous aimé le rock et la pop intemporelle, rendez-vous le vendredi 23 et le dimanche 25 juin 2023 dans le parc du château de Tilloloy, dans la Somme.",
  Date.new(2023, 6, 23 ),
  'db/images_festivals/festival-2.jpg',
  Date.new(2023, 6, 25 ),
  'https://www.retroctrop.fr/',
  [
    'LOUIS BERTIGNAC', 'LARKIN POE', 'CHRIS ISAAK', 'CANNED HEAT', 'CARAVAN',
    'TEXAS', 'BLANKASS', 'BARCLAY JAMES HARVEST', 'LEVEL 42', 'UUHAI', 'LENE LOVICH',
    'MIKA', 'IZIA', 'EDGAR (Edgär)'
  ]
)

file = File.open(Rails.root.join("db/images_festivals/festival-2.jpg"))
retro_c_trop.photo.attach(io: file, filename: "festival.jpg", content_type: "image/jpeg")
retro_c_trop.save!


festival_de_nimes = create_festival(
  'Festival De Nimes',
  'Nimes (30)',
  "Le Festival de Nîmes se déroule depuis 1997 au sein des Arènes de Nîmes. Dans ce monument historique, témoin du passage de l'empire romain, des artistes français et internationaux se produisent chaque été. Stevie Wonder, Muse, Metallica, Pharrell Williams, Johnny Hallyday, Michel Polnaref ou encore Stromae, autant de grands artistes qui ont laissé leur trace à Nïmes.
  Un festival devenu incontournable dans le calendrier des festivaliers chaque été.",
  Date.new(2023, 6, 23 ),
  'db/images_festivals/festival-3.jpg',
  Date.new(2023, 7, 22 ),
  'https://www.festivaldenimes.com/',
  [
    'DAMSO', 'M POKORA', 'LOMEPAL', 'SIMPLY RED', 'SELAH SUE', 'SLIPKNOT', 'SOPRANO', 'FLORENT PAGNY',
    'ZAZIE', 'SAEZ', 'GOJIRA', 'THE BLACK KEYS', 'PLACEBO', 'MICHEL POLNAREFF', 'STARS 80 ENCORE',
    'SAM SMITH', 'JENIFER', 'ARCTIC MONKEYS', 'LUDOVICO EINAUDI', 'CHILLY GONZALES', 'SIGUR ROS', '
    CHRISTOPHE MAE', 'DJADJA & DINAZ', 'LOUISE ATTAQUE', 'DADJU', 'GIMS'
  ]
)

file = File.open(Rails.root.join("db/images_festivals/festival-3.jpg"))
festival_de_nimes.photo.attach(io: file, filename: "festival.jpg", content_type: "image/jpeg")
festival_de_nimes.save!


les_nuits_de_fourviere = create_festival(
  'Les Nuits De Fourviere',
  '6 rue de l’Antiquaille, 69005 Lyon',
  "Les Nuits de Fourvière est un festival de musique et de théâtre qui se déroule chaque année à Lyon. Il se déroule dans le théâtre antique de Fourvière, un lieu classé au patrimoine mondial de l'UNESCO. Le festival propose une programmation éclectique, allant de la musique classique au rock en passant par le théâtre, la danse et le cirque.",
  Date.new(2023, 5, 31 ),
  'db/images_festivals/festival-4.jpg',
  Date.new(2023, 7, 28 ),
  'https://www.nuitsdefourviere.com/',
  [
    'CATHERINE RINGER', 'ORCHESTRE DE L\'OPERA DE LYON', 'BIRELI LAGRENE', 'SYLVAIN LUC', 'VINICIO CAPOSSELA', 'BARO D\'EVEL', 'UNSTILL LIFE', 'MICHEL POLNAREFF',
    'DISIZ', 'ALOÏSE SAUVAGE', 'BERNARD LAVILLIERS', 'SIMPLY RED', 'THE WHITE  ROSE OF ATHENS', 'BOYS BOYS BOYS', 'ANDRE MINVIELLE', 'ALT-J', 'THE BLACK KEYS', 'STAR FEMININE BAND', 'QUEENS OF THE STONE AGE', "BENJAMIN BIOLAY", 'ROBIN MICKELLE',
    'ANTIBALAS', 'ALICE RUSSELL', 'ZAZIE', 'GASPA CLAUS', 'PEDRO SOLER', 'INES BACAN', 'OMAR RAJEH', 'SIGUR ROS', 'DELUXE', 'ISABELLE ADJANI', 'IMANY', 'SOUAD MASSI', 'TAMINO', 'JAN VERSTRAETEN', 'IREN DRESEL', 'FRENCH 79', 'CITRON SUCRE', 'THE BLAZE', 'POMME', 'GHOSTLY KISSES', 'JEANNE ADDED', 'KUMBIA BORUKA', 'LILA DOWNS', 'SON ROMPE PERA'
  ]
)

file = File.open(Rails.root.join("db/images_festivals/festival-4.jpg"))
les_nuits_de_fourviere.photo.attach(io: file, filename: "festival.jpg", content_type: "image/jpeg")
les_nuits_de_fourviere.save!


festival_de_trelaze = create_festival(
  'Festival De Trelaze',
  'Parc du vissoir, 49800 Trélazé',
  "Le Festival de Trélazé est un festival de musique qui se déroule chaque année à Trélazé, dans le Maine-et-Loire. Il se déroule dans le parc du Vissoir, un lieu verdoyant et arboré. Le festival propose une programmation éclectique, allant de la musique classique au rock en passant par le théâtre, la danse et le cirque.",
  Date.new(2023, 6, 21 ),
  'db/images_festivals/festival-5.jpg',
  Date.new(2023, 7, 24 ),
  'https://www.trelaze.fr/ville-evenement/festival-de-trelaze',
  [
    "IMAGINATION FEAT. LEEE JOHN",
    "SHEILA",
    "AMIR",
    "MC SOLAAR",
    "CHARLIE WINSTON",
    "NISKA",
    "STEPHAN EICHER",
    "ROOTSRIDERS",
    "BIGFLO ET OLI",
    "ANDRE MANOUKIAN",
    "VANESSA KAYO",
    "GEREMY CREDEVILLE",
    "KYAN KHOJANDI",
    "MARIE RENO",
    "BAPTISTE LECAPLAIN",
    "JEREMY NADEAU",
    "NASH UP",
    "LES NEGRESSES VERTES",
    "DJIBRIL CISSE TCHEBA",
    "VERONIQUE SANSON",
    "MICHEL POLNAREFF"
  ]
)

file = File.open(Rails.root.join("db/images_festivals/festival-5.jpg"))
festival_de_trelaze.photo.attach(io: file, filename: "festival.jpg", content_type: "image/jpeg")
festival_de_trelaze.save!


solidays = create_festival(
  'Solidays',
  'Hippodrome de Longchamp, 75000 Paris',
  "Solidays est un festival de musique et de solidarité qui se déroule chaque année à Paris. Il se déroule dans l'hippodrome de Longchamp, un lieu verdoyant et arboré. Le festival propose une programmation éclectique, allant de la musique classique au rock en passant par le théâtre, la danse et le cirque.",
  Date.new(2023, 6, 23 ),
  'db/images_festivals/festival-6.jpg',
  Date.new(2023, 6, 25 ),
  'https://www.solidays.org/',
  [
    'TIAKOLA', 'JULIETTE ARMANET', 'LUIDJI', 'SCH', 'SOFIANE PAMART', 'JAIN', 'DJADJA & DINAZ', 'ASCENDANT VIERGE', 'NAAMAN', 'ADE', 'IRENE DRESEL', 'JULIEN GRANEL', 'KERCHAK', 'ZAOUI', 'SALUT C\'EST COOL', 'LEWIS OFMAN', 'KIDS RETURN', 'ANETHA', 'MARABOUTAGE', 'SAMA ABDULHADI', 'KIDDY SMILE', 'EARTHGANG', 'SHLØMO (SCHLOMO)', 'BUG DE L\'AN 2000',
    'ZAHO DE SAGAZAN', 'JOSMAN', 'BIGFLO ET OLI', 'JOK\'AIR', 'ZIAK', 'FAADA FREDDY', 'MIEL DE MONTAGNE', 'VLADIMIR CAUCHEMAR', 'MERYL', 'KALIKA', 'HERVE', 'HYPHEN HYPHEN', 'KUNGS', 'BILLX', 'MANDRAGORA', 'PAROV STELAR', 'ROLAND CRISTAL', 'SAINT LEVANT', 'J. BALVIN', 'MR OIZO',
    'ZOLA', 'SHAKA PONK', 'PIERRE DE MAERE', 'DELUXE', 'ANGELE', 'LA FEMME', 'HAMZA', 'FAVE', 'YOUV DEE', 'REMA', 'OETE', 'GWENDOLINE', 'CERRONE', 'CHRONOLOGIC', 'SHYGIRL'
  ]
)

file = File.open(Rails.root.join("db/images_festivals/festival-6.jpg"))
solidays.photo.attach(io: file, filename: "festival.jpg", content_type: "image/jpeg")
solidays.save!

festival_des_vieilles_charrues = create_festival(
  'Festival des Vieilles Charrues',
  'Carhaix-Plouguer (29)',
  "Le Festival des Vieilles Charrues est un festival de musique qui se déroule chaque année à Carhaix-Plouguer, dans le Finistère. Il se déroule dans le parc du Vissoir, un lieu verdoyant et arboré. Le festival propose une programmation éclectique, allant de la musique classique au rock en passant par le théâtre, la danse et le cirque.",
  Date.new(2023, 7, 13 ),
  'db/images_festivals/festival-7.jpg',
  Date.new(2023, 7, 17 ),
  'https://www.vieillescharrues.asso.fr/',
  [
    'ROBBIE WILLIAMS', 'BIGFLO & OLI', 'DISIZ', 'HYPHEN HYPHEN', 'MORCHEEBA', 'PETIT BISCUIT', 'MIMAA', 'ORANGE BLOSSOM & LES FLEURS DE METAL',
    'PIERRE DE MAERE', 'SILLY BOY BLUE', 'UZI FREYJA', 'THE WAEVE', 'TRAMHAUS', 'TUKAN', 'BLUR', 'AYA NAKAMURA', 'GAZO', 'JEANNE ADDED', 'SHAKA PONK',
    'AGAR AGAR', 'AGORIA', 'BIGA*RANX', 'KO KO MO', 'LASS', 'MERYL', 'REYNZ', 'SBRBS', 'THE CELTIC SOCIAL CLUB', 'BRAMA', 'LA BRUULU (KBA#9)',
    'NONE SOUNDS', 'THE WACKY JUGS', 'ROSALIA', 'LOMEPAL', 'IDLES', 'KUNGS', 'LETO & GUY2BEZBAR', 'POMME', 'SUZANE', 'BILLX', 'EASY LIFE',
    'JOHNNIE CARWASH', 'LEWIS OFMAN', 'MINUIT MACHINE', 'VOYOU', 'ZAHO DE SAGAZAN', 'BARRUT & DIRIDOLLOU LAVIGNE', 'DE LA CRAU', 'FEST NOZ', 'SOPRANO', 'PHOENIX', 'HOT CHIP', 'JAIN', 'LORENZO', 'MODERAT', 'PAUL KALKBRENNER', 'ACID ARAB', 'ADE', 'GWENDOLINE', 'JOYSAD', 'KALIKA', 'MADEMOISELLE K', 'STUFFED FOXES', 'AVALANCHE KAITO', 'KAOLILA', 'PARRANDA LA CRUZ', 'TAXI KEBAB', 'RED HOT CHILI PEPPERS'
  ]
)

file = File.open(Rails.root.join("db/images_festivals/festival-7.jpg"))
festival_des_vieilles_charrues.photo.attach(io: file, filename: "festival.jpg", content_type: "image/jpeg")
festival_des_vieilles_charrues.save!

la_nuit_de_l_erdre = create_festival(
  'La nuit de l\'Erdre',
  '1 Rue de Rocheflour, 44390 Nort-sur-Erdre',
  'Au programme du Festival La Nuit De L\'Erdre 2023, retrouvez de nombreux artistes et groupes de musique en concert à Nort sur Erdre.',
  Date.new(2023, 6, 29),
  'db/images_festivals/festival-8.jpg',
  Date.new(2023, 7, 2),
  'https://www.lanuitdelerdre.fr/',
  [
    'Indochine', 'Lomepal', 'Juliette Armanet', 'Louise Attaque', 'Suzane', 'Biga Ranx', 'La Femme', 'Lorenzo', 'Shaka Ponk',
    'Lujipeka', 'Josman', 'Groundation', 'Franz Ferdinand', 'Phoenix', 'Fatoumata Diawara', 'Feder', 'Martin Solveig', 'Ko Ko Mo',
    'Royal Republic', 'Rag\'n\'bone Man', 'Dirtyphonics', 'Coach Party', 'Foals', 'Green Line Marching Band', 'Dynamite Shakers'
  ]
)

file = File.open(Rails.root.join("db/images_festivals/festival-8.jpg"))
la_nuit_de_l_erdre.photo.attach(io: file, filename: "festival.jpg", content_type: "image/jpeg")
la_nuit_de_l_erdre.save!

hellfest = create_festival(
  'Hellfest',
  'Rue du Champ Louet, 44190 Clisson',
  'Le Hellfest est un festival de musique français spécialisé dans les musiques extrêmes, annuellement organisé au mois de juin à Clisson en Loire-Atlantique. Fondé en 2006, il est aujourd\'hui l\'un des plus importants festivals de musique en France, avec une fréquentation de 180 000 festivaliers en 2019.',
  Date.new(2023, 6, 15),
  'db/images_festivals/festival-9.jpg',
  Date.new(2023, 6, 18),
  'https://www.hellfest.fr/',
  [
    "Kiss", "Hollywood Vampires", "Generation Sex", "Coheed and Cambria",
    "Parkway Drive", "Architects", "In Flames", "I Prevail", "Code Orange",
    "Fishbone", "Svinkels", "Ludwig Von 88", "Poesie zero", "Kamizol-K",
    "Amenra", "The Soft Moon", "DVNE", "Today is the day", "Celeste",
    "Katatonia", "Hypocrisy", "Candlemass", "Nightfall", "Aephanemer",
    "Behemoth", "Dark Funeral", "Harakiri For the Sky", "Imperial Triumphant", "Blackbraid", "Mötley Crüe", "Def Leppard", "Alter Bridge", "Skid Row",
    "Elegant Weapons", "British Lion", "The Quireboys", "P-Trolls",
    "SUM 41", "Machine Gun Kelly", "Papa Roach", "Motionless in white", "Silmaris", "Mod Sun", "Escape The Fate", "Vended",
    "Gogol Bordello", "Rancid", "Flogging Molly", "Less Than Jake", "Cockney Rejects", "The Chats", "Komintern Sect", "Peter Pan Speedrock", "Syndrome 81",
    "Botch", "Triggerfinger", "Greg Puciato", "Weedeater", "Bongripper", "Primitive Man", "Helms Alee", "LLNN", "My Diligence",
    "As I Lay Dying", "Bloodbath", "Belphegor", "Aborted", "Uneath", "Full of Hell", "Nostromo", "Candy", "Venefixion",
    "Venom Inc", "Gorgoroth", "1349", "Vreid", "Der Weg Einer Freiheit", "Akiavel", "Acod", "Belenos", "Hetroertzen",
    "Carpenter Brut", "Iron Maiden", "Porcupine Tree", "Puscifer", "Riverside", "Evergrey", "Enforcer", "Scarlean",
    "Within Temptation", "Powerwolf", "Arch Enemy", "Beast in Black", "Asking Alexandria", "Fever 333", "Bloodywood", "Cobra the Impaler",
    "Municipal Waste", "Black Flag", "Stray for the Path", "Pro-Pain", "Soul GLO", "Mindforce", "Spiritworld", "Zulu", "Hard Mind",
    "Clutch", "Monster Magnet", "Earthless", "The Obsessed", "Grandma's Ashes", "Crowbar", "King Buffalo", "Spirit Adrift", "Decasia",
    "Meshuggah", "Voivod", "Lorna Shore", "Born of Osiris", "Gorod", "Loathe", "Ten56", "The Dali Thundering Concept", "Pestifer",
    "The Hu", "Faun", "Finntroll", "Myrath", "Saor", "Svalbard", "Kalandra", "Hierophant", "Nature Morte",
    "Slipknot", "Tenacious D", "Amon Amarth", "Hatebreed", "Hollywood Undead", "Ho99o9", "Florence Black", "Do or Die",
    "Pantera", "Incubus", "Electric Callboy", "Halestorm", "The Menzingers", "Thundermother", "Skynd",
    "The Ghost Inside", "Rise of the Northstar", "The Amity Affliction", "Paleface", "Cane Hill", "End", "Resolve", "Beyond the Styx",
    "Melvins", "Dance with the Dead", "Mutoid Man", "Dozer", "Legion of Doom", "Empire State Bastard", "Wolvennest", "Doodseskader",
    "Testament", "Dark Angel", "Benediction"
  ]
)
file = File.open(Rails.root.join("db/images_festivals/festival-9.jpg"))
hellfest.photo.attach(io: file, filename: "festival.jpg", content_type: "image/jpeg")
hellfest.save!


les_francofolies_de_la_rochelle = create_festival(
  'Les Francofolies de la Rochelle',
  'Esp. Saint-Jean d\'Acre, 17000 La Rochelle',
  'Les Francofolies de La Rochelle est un festival de musique créé en 1985 par Jean-Louis Foulquier. Il se tient chaque année à La Rochelle, en Charente-Maritime, au mois de juillet. Il est consacré à la chanson francophone.',
  Date.new(2023, 7, 12),
  'db/images_festivals/festival-10.jpg',
  Date.new(2023, 7, 16),
  'https://www.francofolies.fr/',
  [
    "Lomepal", "Matthieu Chedid", "Tiakola", "Louise Attaque", "Izïa", "Soprano", "Renaud", "Louane", "Sheila","Biga Ranx",
    "Deluxe", "Gazo", "Adé", "Cali", "Shaka Ponk", "Michel Polnareff", "Daniel Auteuil", "Pierre De Maere",
    "Bertrand Belin", "Matmatah", "Dj Snake", "Mentissa", "Disiz", "Pomme", "Ange", "Mademoiselle K", "Chilla", "Voyou",
    "Hervé Vilard", "Albin De La Simone", "Clarika", "Maissiat", "November Ultra", "Aurelie Saada", "Emilie Simon",
    "Sly Johnson", "Aime Simone", "Mathias Malzieu", "Bb Jacques", "Yuksek", "Bagarre", "Djadja Et Dinaz", "Mezerg",
    "Flavien Berger", "Star Feminine Band", "Lewis Evans", "Oete", "Daria Nelson", "Perturbator", "Gabi Hartmann",
    "Nicolas Maury", "Birds In Row", "Emmanuel Noblet", "Martin Luminet", "Nina", "Waxx", "San Salvador",
    "Matt Holubowski", "Pierre Guénard", "Contrebande", "Di Bosco", "Sierra", "Thierry Larose", "Nelick", "Uzi",
    "Freyja", "Annie .adaa", "Social Dance", "Lisa Ducasse", "Claude", "Ada Oda", "Neniu", "Rallye", "Yoa",
    "Jeanne Rochette", "Vincent C", "Sunbather"
  ]
)

file = File.open(Rails.root.join("db/images_festivals/festival-10.jpg"))
les_francofolies_de_la_rochelle.photo.attach(io: file, filename: "festival.jpg", content_type: "image/jpeg")
les_francofolies_de_la_rochelle.save!
