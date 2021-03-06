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

Trader.create(name: 'Tom', 
	trader_arn: 'arn:aws:sns:us-east-2:877941893971:tom_feed')
Trader.create(name: 'Vonetta',
	trader_arn:'arn:aws:sns:us-east-2:877941893971:vonetta_feed')
Trader.create(name: 'Fauzia', 
	trader_arn:'arn:aws:sns:us-east-2:877941893971:fauzia_feed')


PlatformApplication.create(platform_name: 'APNS_SANDBOX', 
	platform_arn: 'arn:aws:sns:us-east-1:877941893971:app/APNS_SANDBOX/testPlatformApplication')

User.create(name: 'Sarah', email: 'sarah.briggs@tastytrade.com')
User.create(name: 'Carolyn', email: 'carolyn.blumberg@tastytrade.com')
