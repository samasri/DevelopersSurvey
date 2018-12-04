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

ActiveRecord::Schema.define(version: 2018_11_22_052003) do

  create_table "questions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "question_text"
    t.string "qtype"
    t.boolean "mandatory"
    t.string "responseType"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "responses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "question_id"
    t.string "user_id"
    t.bigint "sentence_id"
    t.string "response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id", "user_id", "sentence_id"], name: "index_responses_on_question_id_and_user_id_and_sentence_id", unique: true
    t.index ["question_id"], name: "index_responses_on_question_id"
    t.index ["sentence_id"], name: "index_responses_on_sentence_id"
  end

  create_table "sentences", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "thread_id"
    t.string "answer_id"
    t.text "sentence_text"
    t.string "technique"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "responses", "questions"
  add_foreign_key "responses", "sentences"
end
