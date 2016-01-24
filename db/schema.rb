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

ActiveRecord::Schema.define(version: 20160124072757) do

  create_table "answers", force: :cascade do |t|
    t.integer  "exam_id",    limit: 4
    t.string   "q_num",      limit: 255
    t.string   "one",        limit: 255
    t.string   "two",        limit: 255
    t.string   "three",      limit: 255
    t.string   "four",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "exam_ranks", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "exam_id",    limit: 4
    t.integer  "total",      limit: 4
    t.integer  "correct",    limit: 4
    t.integer  "wrong",      limit: 4
    t.decimal  "mark",                   precision: 5, scale: 2
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "role",       limit: 255
  end

  add_index "exam_ranks", ["role", "user_id", "exam_id"], name: "index_exam_ranks_on_role_and_user_id_and_exam_id", unique: true, using: :btree

  create_table "exams", force: :cascade do |t|
    t.string   "exam_type",  limit: 255
    t.string   "code",       limit: 255
    t.string   "name",       limit: 255
    t.string   "date",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "exams", ["exam_type", "code"], name: "index_exams_on_exam_type_and_code", unique: true, using: :btree

  create_table "guest_users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_answers", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "exam_id",    limit: 4
    t.string   "booklet",    limit: 255
    t.integer  "q_num",      limit: 4
    t.string   "answer",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "role",       limit: 255
  end

  add_index "user_answers", ["role", "user_id", "exam_id", "q_num"], name: "index_user_answers_on_role_and_user_id_and_exam_id_and_q_num", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "provider",   limit: 255
    t.string   "uid",        limit: 255
    t.string   "name",       limit: 255
    t.string   "image",      limit: 255
    t.string   "token",      limit: 255
    t.datetime "expires_at"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "email",      limit: 255
    t.string   "role",       limit: 255
    t.string   "location",   limit: 255
  end

end
