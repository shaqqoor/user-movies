class Movie < ActiveRecord::Base
    belongs_to :director
    has_many :movie_actors
    has_many :actors, through: :movie_actors
    has_many :user_movies
    has_many :users, through: :user_movies
end