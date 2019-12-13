class Movie < ActiveRecord::Base
    belongs_to :director
    has_many :movie_actors
    has_many :actors, through: :movie_actors
    has_many :user_movies
    has_many :users, through: :user_movies

    def slug
        self.name.split.map { |part| part.downcase }.join("-")
    end

    def self.find_by_slug(slug)
        unslugifed = slug.split("-").map { |part| part.capitalize }.join(" ")
        self.find_by_name(unslugifed)
    end

end