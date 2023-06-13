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

  file = File.open(Rails.root.join(image_path))
  festival.photo.attach(io: file, filename: "#{name.downcase.gsub(' ', '_')}.jpg", content_type: 'image/jpg')
  festival.save!

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

puts '=========== Creating cities ==========='

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


puts '=========== Creating users ==========='

create_user(
  'Drink',
  'Jagger',
  "27",
  'drink-jagger@gmail.com',
  'musicroad',
  'db/avatar/drink_jagger.jpg'
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

puts '=========== Creating festivals ==========='

create_festival(
  'Musicalarue',
  'Luxey (40)',
  'Musicalarue est un festival de musique qui se déroule chaque année à Luxey',
  Date.new(2023, 7, 28),
  'db/images_festivals/festival-1.jpg',
  Date.new(2023, 7, 30),
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

create_festival(
  'Retro C Trop',
  'Rue de Flandre, 80700 Tilloloy',
  "Retro mais toujours dans le vent, ces groupes et artistes qui ont déjà 20, 30, 40 ou même 50 ans de carrière. Alors si vous aimez le rock et la pop intemporelle, rendez-vous le vendredi 23 et le dimanche 25 juin 2023 dans le parc du château de Tilloloy, dans la Somme.",
  Date.new(2023, 6, 23),
  'db/images_festivals/festival-2.jpg',
  Date.new(2023, 6, 25),
  'https://www.retroctrop.fr/',
  [
    'LOUIS BERTIGNAC', 'LARKIN POE', 'CHRIS ISAAK', 'CANNED HEAT', 'CARAVAN',
    'TEXAS', 'BLANKASS', 'BARCLAY JAMES HARVEST', 'LEVEL 42', 'UUHAI', 'LENE LOVICH',
    'MIKA', 'IZIA', 'EDGAR (Edgär)'
  ]
)

create_festival(
  'Festival De Nimes',
  'Nimes (30)',
  "Le Festival de Nîmes se déroule depuis 1997 au sein des Arènes de Nîmes. Dans ce monument historique, témoin du passage de l'empire romain, des artistes français et internationaux se produisent chaque été. Stevie Wonder, Muse, Metallica, Pharrell Williams, Johnny Hallyday, Michel Polnareff ou encore Stromae, autant de grands artistes qui ont laissé leur trace à Nîmes. Un festival devenu incontournable dans le calendrier des festivaliers chaque été.",
  Date.new(2023, 6, 23),
  'db/images_festivals/festival-3.jpg',
  Date.new(2023, 7, 22),
  'https://www.festivaldenimes.com/',
  [
    'DAMSO', 'M POKORA', 'LOMEPAL', 'SIMPLY RED', 'SELAH SUE', 'SLIPKNOT',
    'SOPRANO', 'FLORENT PAGNY', 'ZAZIE', 'SAEZ', 'GOJIRA', 'THE BLACK KEYS',
    'PLACEBO', 'MICHEL POLNAREFF', 'STARS 80 ENCORE', 'SAM SMITH', 'JENIFER',
    'ARCTIC MONKEYS', 'LUDOVICO EINAUDI', 'CHILLY GONZALES', 'SIGUR ROS',
    'CHRISTOPHE MAE', 'DJADJA & DINAZ', 'LOUISE ATTAQUE', 'DADJU', 'GIMS'
  ]
)

create_festival(
  'Les Nuits De Fourviere',
  '6 rue de l’Antiquaille, 69005 Lyon',
  "Les Nuits de Fourvière est un festival de musique et de théâtre qui se déroule chaque année à Lyon. Il se déroule dans le théâtre antique de Fourvière, un lieu classé au patrimoine mondial de l'UNESCO. Le festival propose une programmation éclectique, allant de la musique classique au rock en passant par le théâtre, la danse et le cirque.",
  Date.new(2023, 5, 31),
  'db/images_festivals/festival-4.jpg',
  Date.new(2023, 7, 28),
  'https://www.nuitsdefourviere.com/',
  [
    'CATHERINE RINGER', 'ORCHESTRE DE L\'OPERA DE LYON', 'BIRELI LAGRENE', 'SYLVAIN LUC', 'VINICIO CAPOSSELA',
    'BARO D\'EVEL', 'UNSTILL LIFE', 'MICHEL POLNAREFF', 'DISIZ', 'ALOÏSE SAUVAGE', 'BERNARD LAVILLIERS', 'SIMPLY RED',
    'THE WHITE ROSE OF ATHENS', 'BOYS BOYS BOYS', 'ANDRE MINVIELLE', 'ALT-J', 'THE BLACK KEYS', 'STAR FEMININE BAND',
    'QUEENS OF THE STONE AGE', "BENJAMIN BIOLAY", 'ROBIN MICKELLE', 'ANTIBALAS', 'ALICE RUSSELL', 'ZAZIE',
    'GASPA CLAUS', 'PEDRO SOLER', 'INES BACAN', 'OMAR RAJEH', 'SIGUR ROS', 'DELUXE', 'ISABELLE ADJANI', 'IMANY',
    'SOUAD MASSI', 'TAMINO', 'JAN VERSTRAETEN', 'IREN DRESEL', 'FRENCH 79', 'CITRON SUCRE', 'THE BLAZE', 'POMME',
    'GHOSTLY KISSES', 'JEANNE ADDED', 'KUMBIA BORUKA', 'LILA DOWNS', 'SON ROMPE PERA'
  ]
)

create_festival(
  'Festival De Trelaze',
  'Parc du vissoir, 49800 Trélazé',
  "Le Festival de Trélazé est un festival de musique qui se déroule chaque année à Trélazé, dans le Maine-et-Loire. Il se déroule dans le parc du Vissoir, un lieu verdoyant et arboré. Le festival propose une programmation éclectique, allant de la musique classique au rock en passant par le théâtre, la danse et le cirque.",
  Date.new(2023, 6, 21),
  'db/images_festivals/festival-5.jpg',
  Date.new(2023, 7, 24),
  'https://www.trelaze.fr/ville-evenement/festival-de-trelaze',
  [
    "IMAGINATION FEAT. LEEE JOHN", "SHEILA", "AMIR", "MC SOLAAR", "CHARLIE WINSTON", "NISKA",
    "STEPHAN EICHER", "ROOTSRIDERS", "BIGFLO ET OLI", "ANDRE MANOUKIAN", "VANESSA KAYO",
    "GEREMY CREDEVILLE", "KYAN KHOJANDI", "MARIE RENO", "BAPTISTE LECAPLAIN", "JEREMY NADEAU",
    "NASH UP", "LES NEGRESSES VERTES", "DJIBRIL CISSE TCHEBA", "VERONIQUE SANSON",
    "MICHEL POLNAREFF"
  ]
)

create_festival(
  'Solidays',
  'Hippodrome de Longchamp, 75000 Paris',
  "Solidays est un festival de musique et de solidarité qui se déroule chaque année à Paris. Il se déroule dans l'hippodrome de Longchamp, un lieu verdoyant et arboré. Le festival propose une programmation éclectique, allant de la musique classique au rock en passant par le théâtre, la danse et le cirque.",
  Date.new(2023, 6, 23),
  'db/images_festivals/festival-6.jpg',
  Date.new(2023, 6, 25),
  'https://www.solidays.org/',
  [
    'TIAKOLA', 'JULIETTE ARMANET', 'LUIDJI', 'SCH', 'SOFIANE PAMART', 'JAIN',
    'DJADJA & DINAZ', 'ASCENDANT VIERGE', 'NAAMAN', 'ADE', 'IRENE DRESEL', 'JULIEN GRANEL',
    'KERCHAK', 'ZAOUI', 'SALUT C\'EST COOL', 'LEWIS OFMAN', 'KIDS RETURN', 'ANETHA',
    'MARABOUTAGE', 'SAMA ABDULHADI', 'KIDDY SMILE', 'EARTHGANG', 'SHLØMO (SCHLOMO)',
    'BUG DE L\'AN 2000', 'ZAHO DE SAGAZAN', 'JOSMAN', 'BIGFLO ET OLI', 'JOK\'AIR',
    'ZIAK', 'FAADA FREDDY', 'MIEL DE MONTAGNE', 'VLADIMIR CAUCHEMAR', 'MERYL',
    'KALIKA', 'HERVE', 'HYPHEN HYPHEN', 'KUNGS', 'BILLX', 'MANDRAGORA', 'PAROV STELAR',
    'ROLAND CRISTAL', 'SAINT LEVANT', 'J. BALVIN', 'MR OIZO', 'ZOLA', 'SHAKA PONK',
    'PIERRE DE MAERE', 'DELUXE', 'ANGELE', 'LA FEMME', 'HAMZA', 'FAVE', 'YOUV DEE',
    'REMA', 'OETE', 'GWENDOLINE', 'CERRONE', 'CHRONOLOGIC', 'SHYGIRL'
  ]
)


create_festival(
  'Festival des Vieilles Charrues',
  'Carhaix-Plouguer (29)',
  "Le Festival des Vieilles Charrues est un festival de musique qui se déroule chaque année à Carhaix-Plouguer, dans le Finistère. Il se déroule dans le parc du Vissoir, un lieu verdoyant et arboré. Le festival propose une programmation éclectique, allant de la musique classique au rock en passant par le théâtre, la danse et le cirque.",
  Date.new(2023, 7, 13),
  'db/images_festivals/festival-7.jpg',
  Date.new(2023, 7, 17),
  'https://www.vieillescharrues.asso.fr/',
  [
    'ROBBIE WILLIAMS', 'BIGFLO & OLI', 'DISIZ', 'HYPHEN HYPHEN', 'MORCHEEBA', 'PETIT BISCUIT',
    'MIMAA', 'ORANGE BLOSSOM & LES FLEURS DE METAL', 'PIERRE DE MAERE', 'SILLY BOY BLUE',
    'UZI FREYJA', 'THE WAEVE', 'TRAMHAUS', 'TUKAN', 'BLUR', 'AYA NAKAMURA', 'GAZO',
    'JEANNE ADDED', 'SHAKA PONK', 'AGAR AGAR', 'AGORIA', 'BIGA*RANX', 'KO KO MO',
    'LASS', 'MERYL', 'REYNZ', 'SBRBS', 'THE CELTIC SOCIAL CLUB', 'BRAMA', 'LA BRUULU (KBA#9)',
    'NONE SOUNDS', 'THE WACKY JUGS', 'ROSALIA', 'LOMEPAL', 'IDLES', 'KUNGS',
    'LETO & GUY2BEZBAR', 'POMME', 'SUZANE', 'BILLX', 'EASY LIFE', 'JOHNNIE CARWASH',
    'LEWIS OFMAN', 'MINUIT MACHINE', 'VOYOU', 'ZAHO DE SAGAZAN', 'BARRUT & DIRIDOLLOU LAVIGNE',
    'DE LA CRAU', 'FEST NOZ', 'SOPRANO', 'PHOENIX', 'HOT CHIP', 'JAIN', 'Lorenzo',
    'MODERAT', 'PAUL KALKBRENNER', 'ACID ARAB', 'ADE', 'GWENDOLINE', 'JOYSAD', 'KALIKA',
    'MADEMOISELLE K', 'STUFFED FOXES', 'AVALANCHE KAITO', 'KAOLILA', 'PARRANDA LA CRUZ',
    'TAXI KEBAB', 'RED HOT CHILI PEPPERS'
  ]
)

create_festival(
  'La nuit de l\'Erdre',
  '1 Rue de Rocheflour, 44390 Nort-sur-Erdre',
  'Au programme du Festival La Nuit De L\'Erdre 2023, retrouvez de nombreux artistes et groupes de musique en concert à Nort sur Erdre.',
  Date.new(2023, 6, 29),
  'db/images_festivals/festival-8.jpg',
  Date.new(2023, 7, 2),
  'https://www.lanuitdelerdre.fr/',
  [
    'Indochine', 'Lomepal', 'Juliette Armanet', 'Louise Attaque', 'Suzane', 'Biga Ranx',
    'La Femme', 'Lorenzo', 'Shaka Ponk', 'Lujipeka', 'Josman', 'Groundation',
    'Franz Ferdinand', 'Phoenix', 'Fatoumata Diawara', 'Feder', 'Martin Solveig',
    'Ko Ko Mo', 'Royal Republic', 'Rag\'n\'bone Man', 'Dirtyphonics', 'Coach Party',
    'Foals', 'Green Line Marching Band', 'Dynamite Shakers'
  ]
)

create_festival(
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
    "Behemoth", "Dark Funeral", "Harakiri For the Sky", "Imperial Triumphant",
    "Blackbraid", "Mötley Crüe", "Def Leppard", "Alter Bridge", "Skid Row",
    "Elegant Weapons", "British Lion", "The Quireboys", "P-Trolls",
    "SUM 41", "Machine Gun Kelly", "Papa Roach", "Motionless in white",
    "Silmaris", "Mod Sun", "Escape The Fate", "Vended",
    "Gogol Bordello", "Rancid", "Flogging Molly", "Less Than Jake",
    "Cockney Rejects", "The Chats", "Komintern Sect", "Peter Pan Speedrock",
    "Syndrome 81", "Botch", "Triggerfinger", "Greg Puciato", "Weedeater",
    "Bongripper", "Primitive Man", "Helms Alee", "LLNN", "My Diligence",
    "As I Lay Dying", "Bloodbath", "Belphegor", "Aborted", "Uneath",
    "Full of Hell", "Nostromo", "Candy", "Venefixion",
    "Venom Inc", "Gorgoroth", "1349", "Vreid", "Der Weg Einer Freiheit",
    "Akiavel", "Acod", "Belenos", "Hetroertzen",
    "Carpenter Brut", "Iron Maiden", "Porcupine Tree", "Puscifer", "Riverside",
    "Evergrey", "Enforcer", "Scarlean", "Within Temptation", "Powerwolf",
    "Arch Enemy", "Beast in Black", "Asking Alexandria", "Fever 333",
    "Bloodywood", "Cobra the Impaler", "Municipal Waste", "Black Flag",
    "Stray for the Path", "Pro-Pain", "Soul GLO", "Mindforce",
    "Spiritworld", "Zulu", "Hard Mind", "Clutch", "Monster Magnet",
    "Earthless", "The Obsessed", "Grandma's Ashes", "Crowbar", "King Buffalo",
    "Spirit Adrift", "Decasia", "Meshuggah", "Voivod", "Lorna Shore",
    "Born of Osiris", "Gorod", "Loathe", "Ten56", "The Dali Thundering Concept",
    "Pestifer", "The Hu", "Faun", "Finntroll", "Myrath", "Saor", "Svalbard",
    "Kalandra", "Hierophant", "Nature Morte", "Slipknot", "Tenacious D",
    "Amon Amarth", "Hatebreed", "Hollywood Undead", "Ho99o9", "Florence Black",
    "Do or Die", "Pantera", "Incubus", "Electric Callboy", "Halestorm",
    "The Menzingers", "Thundermother", "Skynd", "The Ghost Inside",
    "Rise of the Northstar", "The Amity Affliction", "Paleface",
    "Cane Hill", "End", "Resolve", "Beyond the Styx", "Melvins",
    "Dance with the Dead", "Mutoid Man", "Dozer", "Legion of Doom",
    "Empire State Bastard", "Wolvennest", "Doodseskader", "Testament",
    "Dark Angel", "Benediction"
  ]
)

create_festival(
  'Les Francofolies de la Rochelle',
  'Esp. Saint-Jean d\'Acre, 17000 La Rochelle',
  'Les Francofolies de La Rochelle est un festival de musique créé en 1985 par Jean-Louis Foulquier. Il se tient chaque année à La Rochelle, en Charente-Maritime, au mois de juillet. Il est consacré à la chanson francophone.',
  Date.new(2023, 7, 12),
  'db/images_festivals/festival-10.jpg',
  Date.new(2023, 7, 16),
  'https://www.francofolies.fr/',
  [
    "Lomepal", "Matthieu Chedid", "Tiakola", "Louise Attaque", "Izïa",
    "Soprano", "Renaud", "Louane", "Sheila", "Biga Ranx", "Deluxe", "Gazo",
    "Adé", "Cali", "Shaka Ponk", "Michel Polnareff", "Daniel Auteuil",
    "Pierre De Maere", "Bertrand Belin", "Matmatah", "Dj Snake",
    "Mentissa", "Disiz", "Pomme", "Ange", "Mademoiselle K", "Chilla",
    "Voyou", "Hervé Vilard", "Albin De La Simone", "Clarika", "Maissiat",
    "November Ultra", "Aurelie Saada", "Emilie Simon", "Sly Johnson",
    "Aime Simone", "Mathias Malzieu", "Bb Jacques", "Yuksek", "Bagarre",
    "Djadja Et Dinaz", "Mezerg", "Flavien Berger", "Star Feminine Band",
    "Lewis Evans", "Oete", "Daria Nelson", "Perturbator", "Gabi Hartmann",
    "Nicolas Maury", "Birds In Row", "Emmanuel Noblet", "Martin Luminet",
    "Nina", "Waxx", "San Salvador", "Matt Holubowski", "Pierre Guénard",
    "Contrebande", "Di Bosco", "Sierra", "Thierry Larose", "Nelick", "Uzi",
    "Freyja", "Annie .adaa", "Social Dance", "Lisa Ducasse", "Claude",
    "Ada Oda", "Neniu", "Rallye", "Yoa", "Jeanne Rochette", "Vincent C",
    "Sunbather"
  ]
)

create_festival(
  'Lollapalooza Paris',
  'Hippodrome de Longchamp, 75000 Paris',
  'Lollapalooza est un festival de musique itinérant créé en 1991 aux États-Unis par Perry Farrell, chanteur du groupe Jane\'s Addiction. Le festival a lieu chaque année aux États-Unis jusqu\'en 1997, puis de 2003 à 2004, et enfin depuis 2005. Il s\'est également exporté dans d\'autres pays, notamment en Amérique du Sud, en Europe et en Asie.',
  Date.new(2023, 7, 21),
  'db/images_festivals/festival-11.jpg',
  Date.new(2023, 7, 23),
  'https://www.lollaparis.com/',
  [
    "AVA MAX", "AYA NAKAMURA", "BEENDO Z", "BENJAMIN EPPS",
    "BIANCA COSTA", "BIICLA", "BLEU CLAIR", "CENTRAL CEE", "CKAY",
    "CLOZEE", "DAMSO", "DEAN LEWIS", "DEATHPACT", "DIRTYPHONICS pres. ELEVATED",
    "DJ DIESEL", "DORIA", "DOYA", "DYLAN", "GENTLEMENS CLUB",
    "HIGH VIS", "HOT MILK", "IMANU b2b THE CARACAL PROJECT", "J.I.D",
    "JAMES BKS", "JOHN BUTLER", "KALEO", "KENDRICK LAMAR", "KL!P",
    "KNOCK2", "KO KO MO", "KOOS", "KYGO", "LIL NAS X", "LINDSEY STIRLING",
    "LOVEJOY", "MAKALA", "MANAL", "MIMI WEBB", "MOSIMANN", "MAISIE PETERS",
    "NIALL HORAN", "NICKI NICOLE", "NISKA", "NITEPUNK", "ONEREPUBLIC",
    "ONLY THE POETS", "PEEKABOO", "PICTURE THIS", "PRINCE WALY", "REZZ",
    "ROSALÌA", "ROYAL REPUBLIC", "SAN HOLO", "SDM", "SLANDER", "SO LA LUNE",
    "STRAY KIDS", "SVDDEN DEATH Presents VOYD", "THE DRIVER ERA",
    "THE INSPECTOR CLUZO", "TOKISCHA", "TONY ROMERA", "WILLIAM BLANKE: William Black b2b Blanke", "2TH"
  ]
)

create_festival(
  'Main Square Festival',
  '49 Place d\'Armes, 62000 Arras',
  'Le Main Square Festival est un festival de musique qui se déroule chaque année au début du mois de juillet sur la Grand-Place d\'Arras, dans le Pas-de-Calais. Il a été créé en 2004 par la ville d\'Arras et l\'association Main Square Festival.',
  Date.new(2023, 6, 30),
  'db/images_festivals/festival-12.jpg',
  Date.new(2023, 7, 2),
  'https://mainsquarefestival.fr/',
  [
    "MAROON 5", "DAMSO", "IZÏA", "KUNGS", "TIAKOLA", "ANNA CALVI",
    "CALUM SCOTT", "CITY AND COLOUR", "YMNK", "GRAND CRU", "ALVIN CHRIS",
    "RAVAGE CLUB", "ORELSAN", "AYA NAKAMURA", "VITALIC LIVE", "HAMZA",
    "LOST FREQUENCIES", "APASHE LIVE WITH BRASS ENSEMBLE", "THE ROSE",
    "ROYAL REPUBLIC", "NOVA TWINS", "HOT MILK", "KONGA", "DEAR DEER",
    "ORANGE DREAM", "CLOUD", "FEU MINERAL", "DAVID GUETTA", "MACKLEMORE",
    "JOHN BUTLER", "FEVER 333", "SUZANE", "SPOON", "BBNO$", "JOÉ DWÈT FILÉ",
    "KO KO MO", "SIR CHLOE", "LYDSTEN", "QUEEN(ARES)", "JUNE BUG", "RETHNO",
    "GANG CLOUDS"
  ]
)

create_festival(
  'Les Eurockéennes de Belfort',
  'Lac du Malsaucy, 90300 Sermamagny',
  'Les Eurockéennes de Belfort est un festival de musique se déroulant chaque année sur la presqu\'île du Malsaucy, près de Belfort, en France. Il est organisé par l\'association Territoire de Musiques, qui a également créé le festival GéNéRiQ.',
  Date.new(2023, 6, 29),
  'db/images_festivals/festival-13.jpg',
  Date.new(2023, 7, 2),
  'https://www.eurockeennes.fr/',
  [
    "SHAKA PONK", "BIGA RANX", "NISKA", "FATOUMATA DIAWARA", "ADE", "PHOENIX",
    "WET LEG", "SKRILLEX", "SIGUR ROS", "THE HAUNTED YOUTH", "PERTURBATOR",
    "JINJER", "SHYGIRL", "BABY VOLCANO", "POGO", "KAYAWOTO", "ZOLA",
    "ORELSAN", "NTO", "MERYL", "FOALS", "070 SHAKE", "YARD ACT", "NATOXIE",
    "HORACE ANDY", "SHANNON", "PUSCIFER", "SINAIVE", "SHAYDEE’S", "FREDDIE GIBBS",
    "ADRIAN SHERWOOD", "SURF CURSE", "JOE UNKNOWN", "LOMEPAL", "POMME",
    "VLADIMIR CAUCHEMAR", "DINOS", "JEANNE ADDED", "GOJIRA", "MEZERG", "KUNGS",
    "LOUS AND THE YAKUZA", "AYRON JONES", "LARKIN POE", "MOONLIGHT BENJAMIN",
    "KIDS RETURN", "SIOUXSIE", "SHLØMO", "DRY CLEANING", "FALLEN LILLIES",
    "ALEISTER", "SAVERIO", "DJ CARLOS WILLENGTON", "UNKNOWN T", "SPECIAL INTEREST",
    "INDOCHINE", "COACH PARTY", "CHEF AND THE GANG"
  ]
)

create_festival(
  'Rock en Seine',
  'Domaine national de Saint-Cloud, 92210 Saint-Cloud',
  'Rock en Seine est un festival de musique rock, pop et électro qui se tient tous les ans au domaine national de Saint-Cloud, à l\'ouest de Paris, le dernier week-end du mois d\'août. Il est organisé par la société AEG Live depuis 2008.',
  Date.new(2023, 8, 23),
  'db/images_festivals/festival-14.jpg',
  Date.new(2023, 8, 27),
  'https://www.rockenseine.com/',
  [
    "Florence + The Machine", "The Chemical Brothers", "Charlotte De Witte",
    "L'impératrice", "Tamino", "Yeah Yeah Yeahs", "Dry Cleaning", "Ethel Cain",
    "Noga Erez", "Overmono", "Altin Gün", "Placebo", "Fever Ray", "Turnstile",
    "Bertrand Belin", "Silly Boy Blue", "Christine and the Queens",
    "Flavien Berger", "Viagra Boys", "Boygenius", "Romy", "Billie Eilish",
    "Girl in red", "Tove Lo", "Hannah Grae", "Lucie Antunes", "The Strokes",
    "Foals", "Wet Leg", "Amyl & the Sniffers", "Bonobo", "Angel Olsen",
    "Gaz Coombes", "The Murder capital", "Nova Twins", "Zed Yun Pavarotti"
  ]
)


create_festival(
  'Musilac',
  'Esplanade du lac, 73100 Aix-les-Bains',
  'Soleil, lac et musique : rendez-vous du 5 au 8 juillet 2023 à Aix-les-Bains pour 4 jours de concerts au bord du Lac du Bourget !',
  Date.new(2023, 7, 5),
  'db/images_festivals/festival-15.jpg',
  Date.new(2023, 7, 8),
  'https://www.musilac.com/',
  [
    "LOMEPAL", "JULIETTE ARMANET", "IZIA", "ARCTIC MONKEYS", "VITALIC", "INHALER",
    "THE MURDER CAPITAL", "SASKIA", "DANIELLE PONDER", "OXIA", "SHAKA PONK", "GOJIRA",
    "SCH", "HYPHEN HYPHEN", "CABALLERO & JEANJASS", "THE HU", "FAKEAR", "OLIVIA DEAN",
    "MALO'", "EAGLE EYE CHERRY", "SÜEÜR", "INDOCHINE", "PETIT BISCUIT", "LUJIPEKA",
    "ZAOUI", "AYRON JONES", "LEWIS OFMAN", "WARHAUS", "COACH PARTY", "WALTER ASTRAL",
    "SIMIA", "HONEYGLAZE", "SELAH SUE", "FRANZ FERDINAND", "PHOENIX", "FLAVIEN BERGER",
    "IGGY POP", "TIWAYO", "PEDRO WINTER AKA BUSY P", "TEMPLES", "CERRONE", "ED BANGER",
    "CRYSTAL MURRAY", "MOODOID"
  ]
)

create_festival(
  'Garorock',
  'Marmande (47)',
  'Le Festival Garorock 2023 vous attend du 29 juin au 2 juillet avec une programmation de folie ! Ce festival en plein air, organisé à Marmande, vient d\'annoncer l\'ensemble de son programme : Macklemore, Boris Brejcha, Skrillex, Lomepal, David Guetta, Rema ou encore Louise Attaque se partagent l\'affiche. On vous dit tout sur la cuvée 2023 de ce festival incontournable de \'été !',
  Date.new(2023, 6, 29),
  'db/images_festivals/festival-16.jpg',
  Date.new(2023, 7, 2),
  'https://www.garorock.com/',
  [
    "DAVID GUETTA", "FRED AGAIN..", "SKRILLEX", "BORIS BREJCHA", "CENTRAL CEE", "GAZO",
    "LOMEPAL", "LOUISE ATTAQUE", "PHOENIX", "REMA", "SHAKA PONK", "TASH SULTANA",
    "THE BLESSED MADONNA", "ADÉ", "AIME SIMONE", "ALMÄ MANGO", "DENIS SULTA", "FEDER",
    "GWENDOLINE", "I HATE MODELS", "KAMPIRE", "LAMBRINI GIRLS", "Lorenzo", "LUJIPEKA",
    "MANDRAGORA", "MERYL", "MUNGO'S HI FI", "NAÂMAN", "PARTIBOI69", "PEDRO WINTER",
    "POGO CAR CRASH CONTROL", "POMME", "SOOM T", "TIAKOLA", "TRAIN FANTÔME", "WINNTERZUKO",
    "WORAKLS ORCHESTRA", "ZAOUI", "ANGELA", "BETWEENATNA", "BILBAO KUNG-FU", "CASABLANCA DRIVERS",
    "D-LISHA", "DARLEAN", "DYLAN DYLAN", "KRIS MUNEGU", "LA FAMILLE MARABOUTAGE", "LEE ANN CURREN",
    "LE KID", "LOU STRUMMER", "MADAM", "MIKE ROCK", "MIX KILLAZ", "MONDOWSKI",
    "MYD", "NICO RODAS", "NOVI SAD", "NUFF LOVE", "OLIVIER CACHIN", "POÉSIE ZÉRO",
    "REBEKA WARRIOR", "S.O UNITY", "SUPER DARONNE", "THE DEAD KRAZUKIES", "WILLIAM NC",
    "YOUTHSTAR X MISCELLANEOUS"
  ]
)

create_festival(
  'Delta Festival',
  '142 Avenue Pierre Mendès France 13008 Marseille',
  'Le Delta Festival est un festival de musique électronique et de sports de glisse qui se tient tous les ans à Marseille, sur les plages du Prado. Il est organisé par la société Delta Festival depuis 2015.',
  Date.new(2023, 8, 23),
  'db/images_festivals/festival-17.jpg',
  Date.new(2023, 8, 27),
  'https://www.delta-festival.com/',
  [
    "Bakermat", "Angerfist", "Damso", "Emma B", "Encasa", "Famille Maraboutage",
    "Hilight Tribe", "Joris Voorn", "Kolter", "Malikk", "Marten Hørger", "Naâman",
    "Occibel", "Ofenbach", "Raphael Palacci", "Worakls Orchestra", "Yungness et Jaminn",
    "Akalex", "Angèle", "Argy", "Cascada", "Charlotte De Witte", "Dirty Doering",
    "Dj Bens", "Dj S.K.T", "Flo Massé", "Francis Mercier", "Grizzy", "Hysta",
    "Ikøn", "Kate Zubok", "Kl!p", "Laolu", "Malaa", "Niconé", "Niska", "Rakoon",
    "Ramyen", "Sara Costa", "The Aarchitectt", "Umaedo", "Ahl Iver", "Alonzo",
    "Amélie Lens", "Artmann", "Basshunter", "Biga*Ranx", "Birds of Mind",
    "Breakbot et Irfane", "David Walters", "Deep Methods", "DVDE", "Grand V",
    "Guz", "H!dude", "Hugo Cantarra", "Jawi", "Mandragora", "Nelick",
    "Nico De Andrea", "Notre Dame", "Oden & Fatzo", "Otta", "Sasson", "Shahin",
    "Acid Oslo", "Agents of Time", "Ahmed spins", "Animals Industry", "Asdek",
    "B.B. Jacques", "Blanc", "Blue Velvet", "DYSK", "Gavinco", "Greg",
    "Infected Mushroom", "Madame Arthur", "Massano", "Mezerg", "Moxo",
    "Niels Ellen", "Planet 51", "Poizon Eli", "Rohm", "Salomé Le Chat",
    "Soeurs Malsaines", "Vandal", "Vanupié", "Viking", "Acid Arab", "Andy 4000",
    "Astrix", "Blaiz Fayah", "Dora", "Elisa Elisa", "Etienne De Crécy", "Feder",
    "Galbinus", "Goldie B", "Kemmler", "Lorenzo", "Luidji", "Nina Kraviz",
    "One Life", "Positive Energy", "Poz Clope", "QQUN", "Ravl", "Rouge",
    "Sens Inverse Agency", "Synapson", "Tino", "Toko", "Twerkistan",
    "Vladimir Dubyshkin", "Watt The Fox"
  ]
)

create_festival(
  'We Love Green',
  'Bois de Vincennes, Paris',
  'We Love Green est un festival de musique et de culture éco-responsable qui se tient chaque année au mois de juin au Bois de Vincennes, à Paris. Il est organisé par les frères Clément et François Hameon, fondateurs de l\'agence de communication We Love Art, et par les producteurs de musique Pedro Winter et Jean-David Levy, fondateurs du label Ed Banger Records.',
  Date.new(2023, 6, 2),
  'db/images_festivals/festival-18.jpg',
  Date.new(2023, 6, 4),
  'https://www.welovegreen.fr/',
  [
    "ORELSAN", "NxWORRIES", "THE BLAZE", "PLK", "YUNG LEAN", "FOLAMOUR A/V",
    "JOHAN PAPACONSTANTINO", "VARNISH LA PISCINE", "JESHI", "SUPERJAZZCLUB", "SURF CURSE", "JOCKSTRAP",
    "JAYDA G", "JYOTY", "ELIZA ROSE", "ANDY 4000", "YVNNIS", "HAICH BER NA",
    "BACCUS", "PHOENIX", "PUSHA T", "GAZO", "Lorenzo", "DISIZ",
    "AGAR AGAR", "LITTLE SIMZ", "DARKSIDE", "HONEY DIJON", "RONISIA", "070 SHAKE",
    "YVES TUMOR", "CHANNEL TRES", "CHARLOTTE ADIGERY & BOLIS PUPUL", "ADRIATIQUE", "MISS MONIQUE",
    "FIONA", "DESIREE", "D4VD", "SAD NIGHT DYNAMITE", "VACRA", "ADELE CASTILLON",
    "SOFIE ROYER", "MAUREEN", "LAZULI", "MOUSE PARTY x MEHDI MAIZI", "MAD REY & JWLES", "FEADZ & UFFIE",
    "ANACO", "TAJAN", "BETTY", "LOMEPAL", "SKRILLEX", "BON IVER",
    "DINOS", "POMME", "KHALI", "JACK JOHNSON", "TEMS", "TWO SHELL",
    "MOODOÏD", "SABRINA BELLAOUEL", "CAROLINE POLACHEK", "ANAIS B", "VTSS", "GABRIELS",
    "AIME SIMONE", "NIA ARCHIVES", "SUDAN ARCHIVES", "J9UEVE", "LUTHER", "WINNTERZUKO",
    "H JEUNECRACK", "CRYSTALLMESS", "CINQUIEME TERRASSE", "GREG & TATYANA JANE", "GRUNT PARTY x NAVA"
  ]
)
