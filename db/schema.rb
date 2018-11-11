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

ActiveRecord::Schema.define(version: 2018_11_11_102230) do

  create_table "questions", id: false, force: :cascade do |t|
    t.integer "questionID"
    t.string "questionText"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "responses", id: false, force: :cascade do |t|
    t.integer "questionID"
    t.string "userID"
    t.integer "sentenceID"
    t.text "response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sentences", id: false, force: :cascade do |t|
    t.integer "sentenceID"
    t.integer "threadID"
    t.string "answerID"
    t.text "sentenceText"
    t.string "technique"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.text "note"
    t.date "completed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_statuses", id: false, force: :cascade do |t|
    t.string "sessionNb"
    t.integer "pageNb"
    t.integer "thread1"
    t.integer "thread2"
    t.integer "thread3"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
