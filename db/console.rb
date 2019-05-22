require_relative("../models/artist")
require_relative("../models/album")
require("pry")

artist_1 = Artist.new({"name" => "Weezer"})
artist_1.save()

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

binding.pry
nil
