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

ActiveRecord::Schema.define(:version => 20130823173044) do

  create_table "albums", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "artist_id"
    t.integer  "year"
  end

  add_index "albums", ["name"], :name => "index_albums_on_name"

  create_table "artists", :force => true do |t|
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "type"
    t.string   "artistname"
    t.text     "story"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "route"
  end

  create_table "attendees", :force => true do |t|
    t.string   "status",     :limit => 16
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.integer  "artist_id"
  end

  create_table "band_members", :force => true do |t|
    t.integer  "artist_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "charges", :force => true do |t|
    t.integer  "amount"
    t.string   "token"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "commentings", :force => true do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "comment_id"
  end

  create_table "comments", :force => true do |t|
    t.text     "text"
    t.integer  "upvotes_total"
    t.string   "location"
    t.integer  "user_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "comment_id"
    t.integer  "commentable_id"
    t.string   "commentable_type", :limit => 64
    t.integer  "commenter_id"
    t.string   "commenter_type"
    t.float    "rating"
  end

  create_table "contact_infos", :force => true do |t|
    t.string   "phone"
    t.string   "email"
    t.string   "website"
    t.integer  "contactable_id"
    t.string   "contactable_type", :limit => 64
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "events", :force => true do |t|
    t.string   "name"
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer  "creator_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "details"
    t.string   "location"
  end

  create_table "followings", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "target_id"
    t.integer  "user_id"
    t.integer  "artist_id"
  end

  create_table "influences", :force => true do |t|
    t.integer  "artist_id"
    t.integer  "influence_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "media", :force => true do |t|
    t.string   "name"
    t.string   "details"
    t.string   "type"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.string   "location"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.integer  "collection_order"
    t.integer  "height"
    t.integer  "width"
    t.boolean  "is_primary"
    t.integer  "media_holder_id"
    t.string   "media_holder_type", :limit => 64
    t.string   "custom_path"
    t.boolean  "is_temporary"
  end

  create_table "play_counts", :force => true do |t|
    t.integer  "media_id"
    t.integer  "user_id"
    t.integer  "count"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "songs", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "artist_id"
    t.integer  "album_id"
    t.integer  "track_number"
    t.string   "soundmap_numbers"
  end

  create_table "users", :force => true do |t|
    t.string   "fname"
    t.string   "lname"
    t.string   "email"
    t.datetime "created_at",                                          :null => false
    t.datetime "updated_at",                                          :null => false
    t.boolean  "willingToBetaTest",                :default => false
    t.boolean  "isBetaTester",                     :default => false
    t.boolean  "isArtist",                         :default => false
    t.string   "password_digest"
    t.boolean  "has_temp_password"
    t.string   "remember_token"
    t.string   "username"
    t.boolean  "is_group",                         :default => false
    t.integer  "facebook_id",         :limit => 8
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "credits",                          :default => 0
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

  create_table "votes", :force => true do |t|
    t.integer  "comment_id"
    t.integer  "user_id"
    t.boolean  "is_upvote"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
