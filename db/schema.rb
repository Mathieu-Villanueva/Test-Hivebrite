# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_04_14_075957) do

  create_table "custom_attributes", force: :cascade do |t|
    t.string "name"
    t.string "value"
    t.boolean "required", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "customizable_type"
    t.integer "customizable_id"
    t.integer "global_attribute_id"
    t.index ["customizable_type", "customizable_id"], name: "index_custom_attributes_on_customizable"
    t.index ["global_attribute_id"], name: "index_custom_attributes_on_global_attribute_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_events_on_name", unique: true
  end

  create_table "global_attributes", force: :cascade do |t|
    t.string "name"
    t.boolean "required"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.boolean "admin", default: false
    t.string "email", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "custom_attributes", "global_attributes"
end
