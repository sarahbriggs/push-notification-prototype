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

Trader.create(name: 'Tom') 
	# 'arn:aws:sns:us-east-2:877941893971:tom_feed')
Trader.create(name: 'Vonetta')
	# 'arn:aws:sns:us-east-2:877941893971:vonetta_feed')
Trader.create(name: 'Fauzia')
	# 'arn:aws:sns:us-east-2:877941893971:fauzia_feed')

User.create(name: 'Sarah', email: 'sarah.briggs@tastytrade.com')
User.create(name: 'Carolyn', email: 'carolyn.blumberg@tastytrade.com')
