# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150109060449) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "battles", force: true do |t|
    t.integer  "user_team_id"
    t.integer  "opponent_team_id"
    t.integer  "user_pokemon_remaining"
    t.integer  "opponent_pokemon_remaining"
    t.boolean  "win"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "selected_team_id"
    t.boolean  "showdown"
    t.integer  "opponent_rating"
  end

  create_table "opponents", force: true do |t|
    t.integer  "team_id"
    t.integer  "rating"
    t.boolean  "showdown"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pokemon_teams", force: true do |t|
    t.integer  "pokemon_id"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_lead"
    t.boolean  "is_back"
  end

  create_table "pokemon_user_teams", force: true do |t|
    t.integer  "user_team_id"
    t.integer  "pokemon_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pokemons", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_teams", force: true do |t|
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

end
