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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130716141838) do

  create_table "poems", :force => true do |t|
    t.text     "original_text"
    t.text     "poem_text"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.integer  "max_syllables", :default => 8
    t.integer  "max_lines",     :default => 4
    t.integer  "user_id"
    t.string   "title",         :default => "Untitled"
    t.string   "pic"
  end

  add_index "poems", ["user_id"], :name => "index_poems_on_user_id"

  create_table "rhyming_relationships", :force => true do |t|
    t.integer  "word_id"
    t.integer  "rhyme_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "rhyming_relationships", ["rhyme_id"], :name => "index_rhyming_relationships_on_rhyme_id"
  add_index "rhyming_relationships", ["word_id"], :name => "index_rhyming_relationships_on_word_id"

  create_table "synonym_relationships", :force => true do |t|
    t.integer  "word_id"
    t.integer  "synonym_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "synonym_relationships", ["synonym_id"], :name => "index_synonym_relationships_on_synonym_id"
  add_index "synonym_relationships", ["word_id"], :name => "index_synonym_relationships_on_word_id"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
  end

  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token"

  create_table "words", :force => true do |t|
    t.string   "spelling"
    t.integer  "syllable_count"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

end
