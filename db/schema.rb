# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_12_12_030230) do

  create_table "actors", force: :cascade do |t|
    t.string "name"
  end

  create_table "directors", force: :cascade do |t|
    t.string "name"
  end

  create_table "movie_actors", force: :cascade do |t|
    t.integer "movie_id"
    t.integer "actor_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "name"
    t.string "year"
    t.string "rating"
    t.integer "director_id"
  end

  create_table "user_movies", force: :cascade do |t|
    t.integer "user_id"
    t.integer "movie_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
  end

end
