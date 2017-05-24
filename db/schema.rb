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

ActiveRecord::Schema.define(version: 20170524192133) do

  create_table "arenas", force: :cascade do |t|
    t.string "battle_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["battle_type"], name: "index_arenas_on_battle_type"
  end

  create_table "contests", force: :cascade do |t|
    t.string "pet_1_id"
    t.string "pet_2_id"
    t.string "winner_id"
    t.integer "arena_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["arena_id"], name: "index_contests_on_arena_id"
    t.index ["pet_1_id"], name: "index_contests_on_pet_1_id"
    t.index ["pet_2_id"], name: "index_contests_on_pet_2_id"
  end

end
