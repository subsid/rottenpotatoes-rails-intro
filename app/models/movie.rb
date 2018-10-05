class Movie < ActiveRecord::Base
  def self.get_ratings
    Movie.select(:rating).map(&:rating).uniq
  end

  def self.movies_by_director movie_title
    director = Movie.find_by(title: movie_title).director
    return nil if director.blank? or director.nil?
    Movie.where(director: director).pluck(:title)
  end
end
