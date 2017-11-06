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

ActiveRecord::Schema.define(version: 20171106080332) do

  create_table "adminlists", force: :cascade do |t|
    t.integer "user_id"
    t.integer "page_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["page_id"], name: "index_adminlists_on_page_id"
    t.index ["user_id"], name: "index_adminlists_on_user_id"
  end

  create_table "identities", force: :cascade do |t|
    t.integer "user_id"
    t.string "email"
    t.string "name"
    t.string "uid"
    t.string "provider"
    t.string "img"
    t.string "img_big"
    t.string "token"
    t.text "other_info"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_identities_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.integer "msg_thread_id"
    t.string "uid"
    t.string "created_time"
    t.string "sender_name"
    t.string "sender_uid"
    t.text "content"
    t.text "attachment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "sender_img"
    t.boolean "received"
    t.text "share"
    t.index ["msg_thread_id"], name: "index_messages_on_msg_thread_id"
  end

  create_table "msg_threads", force: :cascade do |t|
    t.integer "page_id"
    t.string "uid"
    t.string "sender_name"
    t.string "sender_uid"
    t.string "link"
    t.string "msg_count"
    t.string "unread_count"
    t.string "updated_time"
    t.text "other_info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "sender_img"
    t.string "next_token"
    t.string "prev_token"
    t.string "paging_token"
    t.index ["page_id"], name: "index_msg_threads_on_page_id"
  end

  create_table "pages", force: :cascade do |t|
    t.integer "user_id"
    t.string "uid"
    t.string "title"
    t.string "page_name"
    t.text "access_token"
    t.string "img"
    t.integer "unread_msg_count"
    t.integer "unseen_msg_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "next_token"
    t.string "prev_token"
    t.string "paging_token"
    t.index ["user_id"], name: "index_pages_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", default: "Anonymous", null: false
    t.string "uid"
    t.string "provider"
    t.string "img"
    t.string "img_big"
    t.string "facebook_token"
    t.text "other_info"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
