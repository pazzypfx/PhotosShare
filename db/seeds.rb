# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create([{ username: 'username1', firstName: 'firstName1', lastName: 'lastName1', email: 'email1', password_digest: 'password1', active: false },
                     { username: 'username2', firstName: 'firstName2', lastName: 'lastName2', email: 'email2', password_digest: 'password2', active: true  }])

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

photos = Photo.create([{ path: '/images/01.jpg', thumbnail_path: '/thumbnails/01.jpg', user: User.first, variety: Variety.find(1), place: Place.find(1), published: true  },
                       { path: '/images/02.jpg', thumbnail_path: '/thumbnails/02.jpg', user: User.last , variety: Variety.find(1), place: Place.find(1), published: false },
                       { path: '/images/03.jpg', thumbnail_path: '/thumbnails/03.jpg', user: User.first, variety: Variety.find(1), place: Place.find(2), published: true  },
                       { path: '/images/04.jpg', thumbnail_path: '/thumbnails/04.jpg', user: User.last , variety: Variety.find(1), place: Place.find(2), published: true  },
                       { path: '/images/05.jpg', thumbnail_path: '/thumbnails/05.jpg', user: User.first, variety: Variety.find(2), place: Place.find(2), published: true  },
                       { path: '/images/06.jpg', thumbnail_path: '/thumbnails/06.jpg', user: User.last , variety: Variety.find(2), place: Place.find(3), published: true  },
                       { path: '/images/07.jpg', thumbnail_path: '/thumbnails/07.jpg', user: User.first, variety: Variety.find(2), place: Place.find(4), published: false },
                       { path: '/images/08.jpg', thumbnail_path: '/thumbnails/08.jpg', user: User.last , variety: Variety.find(2), place: Place.find(5), published: true  },
                       { path: '/images/09.jpg', thumbnail_path: '/thumbnails/09.jpg', user: User.first, variety: Variety.find(2), place: Place.find(5), published: true  },
                       { path: '/images/10.jpg', thumbnail_path: '/thumbnails/10.jpg', user: User.last , variety: Variety.find(2), place: Place.find(7), published: true  },
                       { path: '/images/11.jpg', thumbnail_path: '/thumbnails/11.jpg', user: User.first, variety: Variety.find(3), place: Place.find(7), published: true  },
                       { path: '/images/12.jpg', thumbnail_path: '/thumbnails/12.jpg', user: User.last , variety: Variety.find(3), place: Place.find(6), published: true  },
                       { path: '/images/13.jpg', thumbnail_path: '/thumbnails/13.jpg', user: User.first, variety: Variety.find(4), place: Place.find(8), published: true  },
                       { path: '/images/14.jpg', thumbnail_path: '/thumbnails/14.jpg', user: User.last , variety: Variety.find(5), place: Place.find(1), published: true  },
                       { path: '/images/15.jpg', thumbnail_path: '/thumbnails/15.jpg', user: User.first, variety: Variety.find(5), place: Place.find(1), published: true  },
                       { path: '/images/16.jpg', thumbnail_path: '/thumbnails/16.jpg', user: User.last , variety: Variety.find(6), place: Place.find(3), published: true  },
                       { path: '/images/17.jpg', thumbnail_path: '/thumbnails/17.jpg', user: User.first, variety: Variety.find(6), place: Place.find(4), published: true  },
                       { path: '/images/18.jpg', thumbnail_path: '/thumbnails/18.jpg', user: User.last , variety: Variety.find(7), place: Place.find(6), published: true  },
                       { path: '/images/19.jpg', thumbnail_path: '/thumbnails/19.jpg', user: User.first, variety: Variety.find(7), place: Place.find(8), published: true  },
                       { path: '/images/20.jpg', thumbnail_path: '/thumbnails/20.jpg', user: User.last , variety: Variety.find(8), place: Place.find(7), published: true  }
                      ])
