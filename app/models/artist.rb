class Artist < ActiveRecord::Base
  has_many :songs
  has_many :genres, through: :songs
  attr_reader :slug

  def slug
    @slug = self.name.downcase.split(" ").join("-")
  end

  def self.find_by_slug(slug)

    Artist.all.each do |artist|
      
      return artist if artist.slug == slug
    end
  end

end
