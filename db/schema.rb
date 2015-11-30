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

ActiveRecord::Schema.define(version: 20150309124356) do

  create_table "board_logs", force: :cascade do |t|
    t.integer  "board_id",    null: false
    t.string   "description", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "board_members", force: :cascade do |t|
    t.integer  "board_id",               null: false
    t.integer  "user_id",                null: false
    t.integer  "permission", default: 0, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "boards", force: :cascade do |t|
    t.string   "name",                    null: false
    t.integer  "wip",         default: 0
    t.text     "description"
    t.integer  "board_id"
    t.integer  "user_id",                 null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "flow_logs", force: :cascade do |t|
    t.integer  "flow_id",     null: false
    t.string   "description", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "flows", force: :cascade do |t|
    t.string   "name",                   null: false
    t.string   "status"
    t.integer  "max_task",   default: 0
    t.integer  "max_day",    default: 0
    t.integer  "order",      default: 0
    t.integer  "board_id",               null: false
    t.integer  "flow_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "logs", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "from",        null: false
    t.string   "to",          null: false
    t.string   "description", null: false
    t.integer  "user_id",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "resources", force: :cascade do |t|
    t.string   "filename",   null: false
    t.string   "filetype",   null: false
    t.string   "servername", null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "task_logs", force: :cascade do |t|
    t.integer  "task_id",     null: false
    t.string   "description", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "name",                    null: false
    t.string   "state"
    t.text     "description"
    t.integer  "order",       default: 0
    t.integer  "flow_id",                 null: false
    t.integer  "user_id"
    t.integer  "type_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "types", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "color",      null: false
    t.integer  "board_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_pin_boards", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "board_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                          null: false
    t.string   "name",                           null: false
    t.string   "password_digest",                null: false
    t.string   "remember_digest"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "sign_in_count",      default: 0, null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

end
