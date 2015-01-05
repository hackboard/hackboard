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

ActiveRecord::Schema.define(version: 20141221123048) do

  create_table "board_logs", force: true do |t|
    t.integer  "board_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "board_members", force: true do |t|
    t.integer  "board_id"
    t.integer  "user_id"
    t.integer  "permission"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "boards", force: true do |t|
    t.string   "name"
    t.integer  "wip"
    t.text     "description"
    t.integer  "board_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "flow_logs", force: true do |t|
    t.integer  "flow_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "flows", force: true do |t|
    t.integer  "max_task"
    t.integer  "max_day"
    t.string   "name"
    t.integer  "order"
    t.integer  "board_id"
    t.integer  "flow_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "logs", force: true do |t|
    t.string   "name"
    t.string   "from"
    t.string   "to"
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resources", force: true do |t|
    t.string   "file_type"
    t.string   "filename"
    t.string   "server_name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "task_logs", force: true do |t|
    t.integer  "task_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", force: true do |t|
    t.string   "state"
    t.string   "name"
    t.integer  "order"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "flow_id"
    t.integer  "type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "types", force: true do |t|
    t.string   "name"
    t.string   "color"
    t.integer  "board_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_pin_boards", id: false, force: true do |t|
    t.integer  "user_id"
    t.integer  "board_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",              default: "", null: false
    t.string   "name",               default: "", null: false
    t.string   "password_digest"
    t.integer  "sign_in_count",      default: 0,  null: false
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_digest"
  end

end
