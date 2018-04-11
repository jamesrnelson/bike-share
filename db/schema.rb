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

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 20180410122109) do
=======
ActiveRecord::Schema.define(version: 20180410205716) do
>>>>>>> 897e64f... Adds slug to stations and modifies stations controller and routes to handle pretty station show url

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

<<<<<<< HEAD
  create_table "carts", force: :cascade do |t|
    t.integer "quantity"
    t.bigint "user_id"
    t.bigint "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_carts_on_item_id"
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

=======
>>>>>>> 897e64f... Adds slug to stations and modifies stations controller and routes to handle pretty station show url
  create_table "conditions", force: :cascade do |t|
    t.string "date"
    t.float "max_temperature"
    t.float "mean_temperature"
    t.float "min_temperature"
    t.float "mean_humidity"
    t.float "mean_visibility"
    t.float "mean_wind_speed"
    t.float "precipitation"
    t.integer "zip_code"
  end
<<<<<<< HEAD

  create_table "items", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.float "price"
    t.integer "status", default: 1
    t.string "image", default: "img_default.jpg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
=======
>>>>>>> 897e64f... Adds slug to stations and modifies stations controller and routes to handle pretty station show url

  create_table "stations", force: :cascade do |t|
    t.string "name"
    t.integer "dock_count"
    t.string "city"
    t.date "installation_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
  end

  create_table "trips", force: :cascade do |t|
    t.integer "duration"
    t.datetime "start_date"
    t.string "start_station"
    t.datetime "end_date"
    t.string "end_station"
    t.integer "bike_id"
    t.string "subscription_type"
    t.integer "zip_code"
  end

  create_table "trips", force: :cascade do |t|
    t.integer "duration"
    t.datetime "start_date"
    t.string "start_station"
    t.datetime "end_date"
    t.string "end_station"
    t.integer "bike_id"
    t.string "subscription_type"
    t.integer "zip_code"
  end

  create_table "users", force: :cascade do |t|
    t.integer "status", default: 0
    t.string "name"
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "carts", "items"
  add_foreign_key "carts", "users"
end
