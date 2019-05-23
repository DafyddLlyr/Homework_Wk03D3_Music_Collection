require_relative("../db/sql_runner")
require_relative("artist")

class Album

  attr_reader :id, :artist_id
  attr_accessor :title, :genre

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @title = options["title"]
    @genre = options["genre"]
    @artist_id = options["artist_id"]
  end

  def save()
    sql = "INSERT INTO albums(title, genre, artist_id) VALUES ($1, $2, $3) RETURNING id"
    values = [@title, @genre, @artist_id]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i
  end

  def delete()
    sql = "DELETE FROM albums WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def artist()
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [@artist_id]
    result = SqlRunner.run(sql, values)
    return Artist.new(result[0])
  end

  def update()
    sql = "UPDATE albums SET (title, genre, artist_id) = ($1, $2, $3)
    WHERE id = $4"
    values = [@title, @genre, @artist_id, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM albums"
    result = SqlRunner.run(sql)
    return result.map { |album| Album.new(album) }
  end

  def self.find(id)
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    return Album.new(result[0])
  end

# Additional features

# Using SQL
  def genre_match()
    sql = "SELECT COUNT (genre) FROM albums WHERE genre = $1"
    values = [@genre]
    result = SqlRunner.run(sql, values)
    return result[0]["count"].to_i
  end

# Using Ruby
  # def genre_match()
  #   result = 0
  #   Album.all.map { |album| result += 1 if album.genre == self.genre}
  #   return result
  # end

end
