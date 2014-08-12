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

ActiveRecord::Schema.define(version: 20140812095100) do

  create_table "joins", force: true do |t|
    t.integer "playorder"
    t.integer "songs_id"
    t.integer "playlists_id"
  end

  create_table "missing_songs", force: true do |t|
    t.string  "artist"
    t.string  "title"
    t.integer "bpm"
    t.string  "key"
    t.string  "key2"
    t.string  "bside"
    t.integer "songs_id"
  end

  create_table "playlists", force: true do |t|
    t.string  "playlistname"
    t.integer "songs_id"
  end

  create_table "songs", force: true do |t|
    t.string  "artist"
    t.string  "title"
    t.integer "bpm"
    t.string  "key"
    t.string  "key2"
    t.string  "bside"
    t.integer "missing_songs_id"
    t.integer "playlists_id"
  end

end
