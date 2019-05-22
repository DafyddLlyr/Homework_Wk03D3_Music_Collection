require_relative("../models/artist")
require_relative("../models/album")
require("pry")

Album.delete_all()
Artist.delete_all()

artist_1 = Artist.new({"name" => "Weezer"})
artist_1.save()

artist_2 = Artist.new({"name" => "Jack Johnson"})
artist_2.save()

artist_3 = Artist.new({"name" => "Kacey Musgraves"})
artist_3.save()

album_1 = Album.new({
  "title" => "The Blue Album",
  "genre" => "Alternative Rock",
  "artist_id" => artist_1.id
  })
album_1.save()

album_2 = Album.new({
  "title" => "The White Album",
  "genre" => "Alternative Rock",
  "artist_id" => artist_1.id
  })
album_2.save()

album_3 = Album.new({
  "title" => "Brushfire Fairytales",
  "genre" => "Folk Rock",
  "artist_id" => artist_2.id
  })
album_3.save()

album_4 = Album.new({
  "title" => "In Between Dreams",
  "genre" => "Folk Rock",
  "artist_id" => artist_2.id
  })
album_4.save()

album_5 = Album.new({
  "title" => "Same Trailer Different Park",
  "genre" => "Country",
  "artist_id" => artist_3.id
  })
album_5.save()

album_6 = Album.new({
  "title" => "Golden Hour",
  "genre" => "Country Pop",
  "artist_id" => artist_3.id
  })
album_6.save()

binding.pry
nil
