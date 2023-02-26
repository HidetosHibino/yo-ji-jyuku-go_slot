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

ActiveRecord::Schema.define(version: 2023_02_26_102240) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "basic_yojis", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "first_kanji_id"
    t.bigint "second_kanji_id"
    t.bigint "third_kanji_id"
    t.bigint "fourth_kanji_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["first_kanji_id"], name: "index_basic_yojis_on_first_kanji_id"
    t.index ["fourth_kanji_id"], name: "index_basic_yojis_on_fourth_kanji_id"
    t.index ["second_kanji_id"], name: "index_basic_yojis_on_second_kanji_id"
    t.index ["third_kanji_id"], name: "index_basic_yojis_on_third_kanji_id"
    t.index ["user_id"], name: "index_basic_yojis_on_user_id"
  end

  create_table "kanjis", force: :cascade do |t|
    t.string "letter", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "slot_yojis", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "first_kanji_id"
    t.bigint "second_kanji_id"
    t.bigint "third_kanji_id"
    t.bigint "fourth_kanji_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["first_kanji_id"], name: "index_slot_yojis_on_first_kanji_id"
    t.index ["fourth_kanji_id"], name: "index_slot_yojis_on_fourth_kanji_id"
    t.index ["second_kanji_id"], name: "index_slot_yojis_on_second_kanji_id"
    t.index ["third_kanji_id"], name: "index_slot_yojis_on_third_kanji_id"
    t.index ["user_id"], name: "index_slot_yojis_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "basic_yojis", "kanjis", column: "first_kanji_id"
  add_foreign_key "basic_yojis", "kanjis", column: "fourth_kanji_id"
  add_foreign_key "basic_yojis", "kanjis", column: "second_kanji_id"
  add_foreign_key "basic_yojis", "kanjis", column: "third_kanji_id"
  add_foreign_key "basic_yojis", "users"
  add_foreign_key "slot_yojis", "kanjis", column: "first_kanji_id"
  add_foreign_key "slot_yojis", "kanjis", column: "fourth_kanji_id"
  add_foreign_key "slot_yojis", "kanjis", column: "second_kanji_id"
  add_foreign_key "slot_yojis", "kanjis", column: "third_kanji_id"
  add_foreign_key "slot_yojis", "users"
end
