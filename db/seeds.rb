# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create([{ username: 'username1', firstName: 'firstName1', lastName: 'lastName1', email: 'email1', password_digest: 'password1', active: false },
                     { username: 'username2', firstName: 'firstName2', lastName: 'lastName2', email: 'email2', password_digest: 'password2', active: true  }])

products = Product.create([{ name: 'Product1', product_code: 'Product1' },
                           { name: 'Product2', product_code: 'Product2' }])

varieties = Variety.create([{ name: 'Variety1', variety_code: 'Variety1',  product: products.first },
                            { name: 'Variety2', variety_code: 'Variety2',  product: products.last  }])

places = Place.create([{ name: 'place1', place_code: 1 },
                       { name: 'place2', place_code: 2 }])

photos = Photo.create([{ path: '/images/01.jpg', thumbnail_path: '/thumbnails/01.jpg', user: User.first, variety: Variety.first, place: Place.last , published: true  },
                       { path: '/images/02.jpg', thumbnail_path: '/thumbnails/02.jpg', user: User.last , variety: Variety.first, place: Place.last , published: false },
                       { path: '/images/03.jpg', thumbnail_path: '/thumbnails/03.jpg', user: User.first, variety: Variety.last , place: Place.last , published: true  },
                       { path: '/images/04.jpg', thumbnail_path: '/thumbnails/04.jpg', user: User.last , variety: Variety.last , place: Place.first, published: false },
                       { path: '/images/05.jpg', thumbnail_path: '/thumbnails/05.jpg', user: User.first, variety: Variety.first, place: Place.first, published: true  },
                       { path: '/images/06.jpg', thumbnail_path: '/thumbnails/06.jpg', user: User.last , variety: Variety.first, place: Place.first, published: true  },
                       { path: '/images/07.jpg', thumbnail_path: '/thumbnails/07.jpg', user: User.first, variety: Variety.last , place: Place.last , published: true  },
                       { path: '/images/08.jpg', thumbnail_path: '/thumbnails/08.jpg', user: User.last , variety: Variety.last , place: Place.last , published: true  },
                       { path: '/images/09.jpg', thumbnail_path: '/thumbnails/09.jpg', user: User.first, variety: Variety.first, place: Place.last , published: true  },
                       { path: '/images/10.jpg', thumbnail_path: '/thumbnails/10.jpg', user: User.last , variety: Variety.first, place: Place.first, published: true  },
                       { path: '/images/11.jpg', thumbnail_path: '/thumbnails/11.jpg', user: User.first, variety: Variety.last , place: Place.first, published: false },
                       { path: '/images/12.jpg', thumbnail_path: '/thumbnails/12.jpg', user: User.last , variety: Variety.last , place: Place.first, published: true  }])