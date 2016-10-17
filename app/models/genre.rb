class Genre < ActiveRecord::Base
  has_many :song_genres

  has_many :songs, through: :song_genres

  has_many :artists, through: :song_genres, :source => :song

  def slug
    @slug = self.name.downcase.split(" ").join("-")

  end

  def self.find_by_slug(slug)

    Genre.all.each do |genre|

      return genre if genre.slug == slug
    end
  end

end
