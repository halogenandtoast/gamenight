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

ActiveRecord::Schema.define(version: 20170123084434) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "boxes", force: true do |t|
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.integer  "game_id"
    t.string   "title"
  end

  add_index "boxes", ["location_id"], name: "index_boxes_on_location_id", using: :btree
  add_index "boxes", ["owner_id", "owner_type"], name: "index_boxes_on_owner_id_and_owner_type", using: :btree

  create_table "comment", force: true do |t|
    t.string  "message", limit: nil, null: false
    t.integer "user_id", limit: 8
  end

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "email", force: true do |t|
    t.string  "email",   limit: nil, null: false
    t.integer "user_id", limit: 8
    t.string  "verkey",  limit: nil
  end

  add_index "email", ["email"], name: "unique_email", unique: true, using: :btree

  create_table "games", force: true do |t|
    t.string   "title"
    t.json     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "retrieved",  default: false
    t.string   "bgg_id"
    t.string   "year"
  end

  add_index "games", ["bgg_id"], name: "index_games_on_bgg_id", unique: true, using: :btree

  create_table "group_memberships", force: true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "group_memberships", ["group_id"], name: "index_group_memberships_on_group_id", using: :btree
  add_index "group_memberships", ["user_id"], name: "index_group_memberships_on_user_id", using: :btree

  create_table "groups", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "time_zone",  default: "UTC"
  end

  create_table "invitations", force: true do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
    t.integer  "sender_id"
  end

  add_index "invitations", ["group_id"], name: "index_invitations_on_group_id", using: :btree
  add_index "invitations", ["sender_id"], name: "index_invitations_on_sender_id", using: :btree
  add_index "invitations", ["user_id"], name: "index_invitations_on_user_id", using: :btree

  create_table "locations", force: true do |t|
    t.string   "title"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "recurrence_rules"
    t.date     "starts_on"
    t.text     "notes"
    t.time     "starts_at"
  end

  add_index "locations", ["group_id"], name: "index_locations_on_group_id", using: :btree

  create_table "password_resets", force: true do |t|
    t.integer  "user_id"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "password_resets", ["user_id"], name: "index_password_resets_on_user_id", using: :btree

  create_table "rsvps", force: true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "request"
  end

  add_index "rsvps", ["group_id"], name: "index_rsvps_on_group_id", using: :btree
  add_index "rsvps", ["user_id"], name: "index_rsvps_on_user_id", using: :btree

  create_table "user", force: true do |t|
    t.string "ident",    limit: nil, null: false
    t.string "password", limit: nil
  end

  add_index "user", ["ident"], name: "unique_user", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "status",          default: "active"
    t.string   "token"
    t.string   "bgg_username"
    t.string   "time_zone",       default: "UTC"
  end

  create_table "votes", force: true do |t|
    t.integer "user_id"
    t.integer "game_id"
    t.integer "group_id"
    t.date    "voted_for", null: false
  end

  add_index "votes", ["game_id"], name: "index_votes_on_game_id", using: :btree
  add_index "votes", ["group_id"], name: "index_votes_on_group_id", using: :btree
  add_index "votes", ["user_id"], name: "index_votes_on_user_id", using: :btree

end
