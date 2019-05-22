require_relative("../db/sql_runner")
require_relative("album")

class Artist

  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
  end

  def save()
    sql = "INSERT INTO artists(name) VALUES ($1) RETURNING id"
    values = [@name]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i
  end

  def albums()
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.map { |album| Album.new(album) }
  end

  def delete()
    sql = "DELETE FROM artists WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE artists SET name = $1 WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM artists"
    result = SqlRunner.run(sql)
    return result.map { |artist| Artist.new(artist) }
  end

  def self.delete_all()
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end

  def self.find(id)
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    return Artist.new(result[0])
  end

# Additional features

# Using SQL
  def album_count()
    sql = "SELECT COUNT (title) FROM albums WHERE artist_id = $1"
    values = [@id]
    return SqlRunner.run(sql, values)[0]["count"].to_i
  end

# Using Ruby
  # def album_count()
  #   return self.albums.length()
  # end

# Using SQL
  def list_genres()
    sql = "SELECT DISTINCT genre FROM albums WHERE artist_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.map { |genre| genre["genre"] }
  end

# Using Ruby
  # def list_genres()
  #   return self.albums.map { |album| album.genre }.uniq
  # end

  def self.all_genres
    sql = "SELECT DISTINCT genre FROM albums"
    result = SqlRunner.run(sql)
    return result.map { |genre| genre["genre"] }
  end

# Using Ruby
  # def self.all_genres()
  #   return self.all.map { |artist| artist.list_genres}.flatten.uniq
  # end

# Using SQL
  def self.genre_count
    sql = "SELECT COUNT (DISTINCT genre) FROM albums"
    result = SqlRunner.run(sql)
    return result[0]["count"].to_i
  end

# Using Ruby
  # def self.genre_count
  #   return self.all_genres().count()
  # end

end
