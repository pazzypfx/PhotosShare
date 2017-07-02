# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create([{ username: 'user' , firstName: 'simple', lastName: 'user', email: 'user_email@test.com' , password_digest: User.digest('pass'), active: true },
                     { username: 'admin', firstName: 'admin' , lastName: 'user', email: 'admin_email@test.com', password_digest: User.digest('pass'), active: true }])

products = Product.create([{ name: 'Poivron'  , product_code: 'poivron'   },
                           { name: 'Aubergine', product_code: 'aubergine' },
                           { name: 'Tomate'   , product_code: 'tomate'    },
                           { name: 'Concombre', product_code: 'concombre' },
                           { name: 'Piment'   , product_code: 'piment'    }
                          ])

varieties = Variety.create([{ name: 'poivron salade'  , variety_code: 'thor_F1'   ,  product: Product.find(1) },
                            { name: 'Le rustique'     , variety_code: 'Kromo_F1'  ,  product: Product.find(1) },
                            { name: 'Idéal à cuisiner', variety_code: 'Kadmio_F1' ,  product: Product.find(1) },
                            { name: 'Zafira F1'       , variety_code: 'Zafira_F1' ,  product: Product.find(2) },
                            { name: 'Sereina F1'      , variety_code: 'Sereina_F1',  product: Product.find(3) },
                            { name: 'Guelma F1'       , variety_code: 'Guelma_F1' ,  product: Product.find(3) },
                            { name: 'Soror F1'        , variety_code: 'Soror_F1'  ,  product: Product.find(4) },
                            { name: 'Sultan F1'       , variety_code: 'Sultan_F1' ,  product: Product.find(5) }
                           ])

places = Place.create([{ name: 'Batna'  , place_code: 5  },
                       { name: 'Biskra' , place_code: 7  },
                       { name: 'Blida'  , place_code: 9  },
                       { name: 'Tiaret' , place_code: 14 },
                       { name: 'Setif'  , place_code: 19 },
                       { name: 'Guelma' , place_code: 24 },
                       { name: 'El oued', place_code: 39 },
                       { name: 'Tipaza' , place_code: 42 }
                      ])

photos = Photo.create([{ path: File.open(Rails.root.join('db', 'seeds', 'images' ,'01.jpg')), user: User.first, variety: Variety.find(1), place: Place.find(1), published: true  },
                       { path: File.open(Rails.root.join('db', 'seeds', 'images' ,'02.jpg')), user: User.last , variety: Variety.find(1), place: Place.find(1), published: false },
                       { path: File.open(Rails.root.join('db', 'seeds', 'images' ,'03.jpg')), user: User.first, variety: Variety.find(1), place: Place.find(2), published: true  },
                       { path: File.open(Rails.root.join('db', 'seeds', 'images' ,'04.jpg')), user: User.last , variety: Variety.find(1), place: Place.find(2), published: true  },
                       { path: File.open(Rails.root.join('db', 'seeds', 'images' ,'05.jpg')), user: User.first, variety: Variety.find(2), place: Place.find(2), published: true  },
                       { path: File.open(Rails.root.join('db', 'seeds', 'images' ,'06.jpg')), user: User.last , variety: Variety.find(2), place: Place.find(3), published: true  },
                       { path: File.open(Rails.root.join('db', 'seeds', 'images' ,'07.jpg')), user: User.first, variety: Variety.find(2), place: Place.find(4), published: false },
                       { path: File.open(Rails.root.join('db', 'seeds', 'images' ,'08.jpg')), user: User.last , variety: Variety.find(2), place: Place.find(5), published: true  },
                       { path: File.open(Rails.root.join('db', 'seeds', 'images' ,'09.jpg')), user: User.first, variety: Variety.find(2), place: Place.find(5), published: true  },
                       { path: File.open(Rails.root.join('db', 'seeds', 'images' ,'10.jpg')), user: User.last , variety: Variety.find(2), place: Place.find(7), published: true  },
                       { path: File.open(Rails.root.join('db', 'seeds', 'images' ,'11.jpg')), user: User.first, variety: Variety.find(3), place: Place.find(7), published: true  },
                       { path: File.open(Rails.root.join('db', 'seeds', 'images' ,'12.jpg')), user: User.last , variety: Variety.find(3), place: Place.find(6), published: true  },
                       { path: File.open(Rails.root.join('db', 'seeds', 'images' ,'13.jpg')), user: User.first, variety: Variety.find(4), place: Place.find(8), published: true  },
                       { path: File.open(Rails.root.join('db', 'seeds', 'images' ,'14.jpg')), user: User.last , variety: Variety.find(5), place: Place.find(1), published: true  },
                       { path: File.open(Rails.root.join('db', 'seeds', 'images' ,'15.jpg')), user: User.first, variety: Variety.find(5), place: Place.find(1), published: true  },
                       { path: File.open(Rails.root.join('db', 'seeds', 'images' ,'16.jpg')), user: User.last , variety: Variety.find(6), place: Place.find(3), published: true  },
                       { path: File.open(Rails.root.join('db', 'seeds', 'images' ,'17.jpg')), user: User.first, variety: Variety.find(6), place: Place.find(4), published: true  },
                       { path: File.open(Rails.root.join('db', 'seeds', 'images' ,'18.jpg')), user: User.last , variety: Variety.find(7), place: Place.find(6), published: true  },
                       { path: File.open(Rails.root.join('db', 'seeds', 'images' ,'19.jpg')), user: User.first, variety: Variety.find(7), place: Place.find(8), published: true  },
                       { path: File.open(Rails.root.join('db', 'seeds', 'images' ,'20.jpg')), user: User.last , variety: Variety.find(8), place: Place.find(7), published: true  }
                      ])
