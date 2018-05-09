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

ActiveRecord::Schema.define(version: 20180507134521) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "currencies", force: :cascade do |t|
    t.string "name"
    t.integer "fetch_id"
    t.string "symbol", null: false
    t.float "current_price"
    t.integer "rank"
    t.float "circulating_supply"
    t.float "total_supply"
    t.float "max_supply"
    t.float "price_eur"
    t.float "price_inr"
    t.float "volume_24h_usd"
    t.float "volume_24h_inr"
    t.float "volume_24h_eur"
    t.float "perc_change_1h_usd"
    t.float "perc_change_24h_usd"
    t.float "perc_change_7d_usd"
    t.float "perc_change_1h_inr"
    t.float "perc_change_24h_inr"
    t.float "perc_change_7d_inr"
    t.float "perc_change_1h_eur"
    t.float "perc_change_24h_eur"
    t.float "perc_change_7d_eur"
    t.float "market_cap_usd"
    t.float "market_cap_inr"
    t.float "market_cap_eur"
    t.datetime "update_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["symbol"], name: "index_currencies_on_symbol", unique: true
  end

  create_table "currency_histories", force: :cascade do |t|
    t.bigint "currency_id"
    t.float "current_price"
    t.integer "rank"
    t.float "circulating_supply"
    t.float "total_supply"
    t.float "max_supply"
    t.float "price_eur"
    t.float "price_inr"
    t.float "volume_24h_usd"
    t.float "volume_24h_inr"
    t.float "volume_24h_eur"
    t.float "perc_change_1h_usd"
    t.float "perc_change_24h_usd"
    t.float "perc_change_7d_usd"
    t.float "perc_change_1h_inr"
    t.float "perc_change_24h_inr"
    t.float "perc_change_7d_inr"
    t.float "perc_change_1h_eur"
    t.float "perc_change_24h_eur"
    t.float "perc_change_7d_eur"
    t.float "market_cap_usd"
    t.float "market_cap_inr"
    t.float "market_cap_eur"
    t.datetime "update_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["currency_id"], name: "index_currency_histories_on_currency_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "user_id"
    t.string "title"
    t.string "content"
    t.string "icon_name"
    t.string "type"
    t.boolean "read"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
