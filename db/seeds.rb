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

photos = Photo.create([{ path: '/images/01.jpg', thumbnail_path: '/thumbnails/01.jpg', user: User.first, variety: Variety.first, place: Place.first, published: true  },
                       { path: '/images/02.jpg', thumbnail_path: '/thumbnails/02.jpg', user: User.last,  variety: Variety.last,  place: Place.last,  published: false },
                       { path: '/images/03.jpg', thumbnail_path: '/thumbnails/03.jpg', user: User.last,  variety: Variety.first, place: Place.last,  published: true  }])