class Song
  extend Concerns::Findable
  attr_accessor :name
  attr_reader :artist, :genre
  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist #evoking self.artist if there is an artist. Otherwise, it will do artist= method
    self.genre = genre if genre
    @@all << self
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    @@all << self
  end

  def self.create(song)
    Song.new(song)
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
      @genre = genre
      genre.songs << self unless genre.songs.include?(self)
  end

  def self.new_from_filename(file)
    artist_name = file.split(" - ")[0]
    song_name = file.split(" - ")[1]
    song = self.new(song_name)
    song.artist = artist=(artist_name)
    song
  end
end
