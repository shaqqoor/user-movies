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

end