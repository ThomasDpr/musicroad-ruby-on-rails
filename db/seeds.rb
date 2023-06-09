puts 'Cleaning database...'
FestivalsArtist.destroy_all
City.destroy_all
Artist.destroy_all
Festival.destroy_all
User.destroy_all


def create_festival(name, location, description, start_date, image_path, artist_names)
  puts "Creating festival: #{name}..."

  festival = Festival.create!(
    name: name,
    location: location,
    description: description,
    start_date: Date.new(*start_date.split('/').reverse.map(&:to_i)).strftime('%d/%m/%Y')

  )

  file = File.open(Rails.root.join(image_path))
  festival.photo.attach(io: file, filename: 'image.jpg', content_type: 'image/jpg')
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
  '28/07/2023',
  'db/images_festivals/festival-card-bg.jpg',
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

retro_c_trop = create_festival(
  'Retro C Trop',
  'Tilloloy (80)',
  "Retro mais toujours dans le vent, ces groupes et artistes qui ont déjà 20, 30, 40 ou même 50 ans de carrière. Alors si vous aimé le rock et la pop intemporelle, rendez-vous le vendredi 23 et le dimanche 25 juin 2023 dans le parc du château de Tilloloy, dans la Somme.",
  '23/06/2023',
  'db/images_festivals/festival-card-bg.jpg',
  [
    'LOUIS BERTIGNAC', 'LARKIN POE', 'CHRIS ISAAK', 'CANNED HEAT', 'CARAVAN',
    'TEXAS', 'BLANKASS', 'BARCLAY JAMES HARVEST', 'LEVEL 42', 'UUHAI', 'LENE LOVICH',
    'MIKA', 'IZIA', 'EDGAR (Edgär)'
  ]
)

festival_de_nimes = create_festival(
  'Festival De Nimes',
  'Nimes (30)',
  "Le Festival de Nîmes se déroule depuis 1997 au sein des Arènes de Nîmes. Dans ce monument historique, témoin du passage de l'empire romain, des artistes français et internationaux se produisent chaque été. Stevie Wonder, Muse, Metallica, Pharrell Williams, Johnny Hallyday, Michel Polnaref ou encore Stromae, autant de grands artistes qui ont laissé leur trace à Nïmes.
  Un festival devenu incontournable dans le calendrier des festivaliers chaque été.",
  '23/06/2023',
  'db/images_festivals/festival-card-bg.jpg',
  [
    'DAMSO', 'M. POKORA', 'JENIFER', 'SIMPLY RED', 'SELAH SUE', 'SLIPKNOT', 'SOPRANO', 'FLORENT PAGNY',
    'ZAZIE', 'SAEZ', 'GOJIRA', 'THE BLACK KEYS', 'PLACEBO', 'MICHEL POLNAREFF', 'STARS 80 ENCORE !',
    'SAM SMITH', 'LOMEPAL', 'ARCTIC MONKEYS', 'LUDOVICO EINAUDI', 'CHILLY GONZALES', 'SIGUR ROS', '
    CHRISTOPHE MAE', 'DJADJA & DINAZ', 'LOUISE ATTAQUE', 'DADJU', 'GIMS'
  ]
)

les_nuits_de_fourviere = create_festival(
  'Les Nuits De Fourviere',
  'Lyon (69)',
  "Les Nuits de Fourvière est un festival de musique et de théâtre qui se déroule chaque année à Lyon. Il se déroule dans le théâtre antique de Fourvière, un lieu classé au patrimoine mondial de l'UNESCO. Le festival propose une programmation éclectique, allant de la musique classique au rock en passant par le théâtre, la danse et le cirque.",
  '07/06/2023',
  'db/images_festivals/festival-card-bg.jpg',
  [
    'CATHERINE RINGER', 'ORCHESTRE DE L\'OPERA DE LYON', 'BIRELI LAGRENE', 'SYLVAIN LUC', 'VINICIO CAPOSSELA', 'BARO D\'EVEL', 'UNSTILL LIFE', 'MICHEL POLNAREFF',
    'DISIZ', 'ALOÏSE SAUVAGE', 'BERNARD LAVILLIERS', 'SIMPLY RED', 'THE WHITE  ROSE OF ATHENS', 'BOYS BOYS BOYS', 'ANDRE MINVIELLE', 'ALT-J', 'THE BLACK KEYS', 'STAR FEMININE BAND', 'QUEENS OF THE STONE AGE', "BENJAMIN BIOLAY", 'ROBIN MICKELLE',
    'ANTIBALAS', 'ALICE RUSSELL', 'ZAZIE', 'GASPA CLAUS', 'PEDRO SOLER', 'INES BACAN', 'OMAR RAJEH', 'SIGUR ROS', 'DELUXE', 'ISABELLE ADJANI', 'IMANY', 'SOUAD MASSI', 'TAMINO', 'JAN VERSTRAETEN', 'IREN DRESEL', 'FRENCH 79', 'CITRON SUCRE', 'THE BLAZE', 'POMME', 'GHOSTLY KISSES', 'JEANNE ADDED', 'KUMBIA BORUKA', 'LILA DOWNS', 'SON ROMPE PERA'
  ]
)

festival_de_trelaze = create_festival(
  'Festival De Trelaze',
  'Trelaze (49)',
  "Le Festival de Trélazé est un festival de musique qui se déroule chaque année à Trélazé, dans le Maine-et-Loire. Il se déroule dans le parc du Vissoir, un lieu verdoyant et arboré. Le festival propose une programmation éclectique, allant de la musique classique au rock en passant par le théâtre, la danse et le cirque.",
  '21/06/2023',
  'db/images_festivals/festival-card-bg.jpg',
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

solidays = create_festival(
  'Solidays',
  'Paris (75)',
  "Solidays est un festival de musique et de solidarité qui se déroule chaque année à Paris. Il se déroule dans l'hippodrome de Longchamp, un lieu verdoyant et arboré. Le festival propose une programmation éclectique, allant de la musique classique au rock en passant par le théâtre, la danse et le cirque.",
  '23/06/2023',
  'db/images_festivals/festival-card-bg.jpg',
  [
    'TIAKOLA', 'JULIETTE ARMANET', 'LUIDJI', 'SCH', 'SOFIANE PAMART', 'JAIN', 'DJADJA & DINAZ', 'ASCENDANT VIERGE', 'NAAMAN', 'ADE', 'IRENE DRESEL', 'JULIEN GRANEL', 'KERCHAK', 'ZAOUI', 'SALUT C\'EST COOL', 'LEWIS OFMAN', 'KIDS RETURN', 'ANETHA', 'MARABOUTAGE', 'SAMA ABDULHADI', 'KIDDY SMILE', 'EARTHGANG', 'SHLØMO (SCHLOMO)', 'BUG DE L\'AN 2000',
    'ZAHO DE SAGAZAN', 'JOSMAN', 'BIGFLO ET OLI', 'JOK\'AIR', 'ZIAK', 'FAADA FREDDY', 'MIEL DE MONTAGNE', 'VLADIMIR CAUCHEMAR', 'MERYL', 'KALIKA', 'HERVE', 'HYPHEN HYPHEN', 'KUNGS', 'BILLX', 'MANDRAGORA', 'PAROV STELAR', 'ROLAND CRISTAL', 'SAINT LEVANT', 'J. BALVIN', 'MR OIZO',
    'ZOLA', 'SHAKA PONK', 'PIERRE DE MAERE', 'DELUXE', 'ANGELE', 'LA FEMME', 'HAMZA', 'FAVE', 'YOUV DEE', 'REMA', 'OETE', 'GWENDOLINE', 'CERRONE', 'CHRONOLOGIC', 'SHYGIRL'
  ]
)

#créer une chatroom
#create chatroom ( 1 = Chatroom.create ())
#
