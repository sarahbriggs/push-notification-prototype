# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# create_table "traders", force: :cascade do |t|
#     t.integer "trader_id"
#     t.string "name"
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#   end

#   create_table "users", force: :cascade do |t|
#     t.integer "user_id"
#     t.string "name"
#     t.string "email"
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#   end

Trader.create(trader_id: 0, name: 'Tom')
Trader.create(trader_id: 1, name: 'Vonetta')

User.create(user_id: 0, name: 'Sarah', email: 'sarah.briggs@tastytrade.com')
User.create(user_id: 1, name: 'Carolyn', email: 'carolyn.blumberg@tastytrade.com')
