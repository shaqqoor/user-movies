class Actor < ActiveRecord::Base
    has_many :movie_actors
    has_many :movies, through: :movie_actors

    def self.find_or_create_actors(actors_str)
        actors = []
        actors_str.split(", ").each do |actor_name|
            actors << self.find_or_create_by(name: actor_name)
        end
        actors
    end

    def slug
        self.name.split.map { |part| part.downcase }.join("-")
    end

    def self.find_by_slug(slug)
        unslugifed = slug.split("-").map { |part| part.capitalize }.join(" ")
        self.find_by_name(unslugifed)
    end

end