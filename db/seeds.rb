# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'ffaker'

# gogoro stations
Gostation.destroy_all

url = 'https://webapi.gogoro.com/api/vm/list'
uri = URI(url)
response = Net::HTTP.get(uri)
json = JSON.parse(response)

json.each do |data|
  Gostation.create!(
    LocName:       find_zh_TW( JSON.parse(data['LocName']) ),
    Latitude:      data['Latitude'],
    Longitude:     data['Longitude'],
    ZipCode:       data['ZipCode'],
    Address:       find_zh_TW( JSON.parse(data['Address']) ),
    District:      find_zh_TW( JSON.parse(data['District']) ),
    City:          find_zh_TW( JSON.parse(data['City']) ),
    AvailableTime: '24HR',
    StorePhoto:    data['StorePhoto'][0],
    BatteryCells:  rand(1..4)*8
  )
end

puts "have created gostations!"
puts "now you have #{Gostation.count} gostations!"


# User
User.destroy_all

User.create!(
  name: "adminuser", email: "admin@example.com", password: "123456", role: "admin"
  )
puts "Default admin created!"

30.times do |i|
  user_name = FFaker::Name.first_name
  User.create!(email: "user#{i}@example.com", password: "123456", name: "#{user_name}")
end
puts "now you have #{User.count} users data!"


Followship.destroy_all

User.all.each do |current|
  User.all.sample(10) do |following|
    current.followships.create!(user_id: current.id, following_id: following.id)
  end
end
puts "User's followships created"

Checkin.destroy_all

User.all.each do |u|
  Gostation.all.sample(rand(10..20)).each do |g|
    g.checkins.create!(user: u)
    rand_pts = rand(300..600)
    u.add_points(rand_pts, category: 'gostation')
    u.experience += rand_pts
    u.save
  end
end
puts "Checkins created"

# Products
Product.destroy_all

Product.create!(name:"GOGORO 安全帽 S PERFORMANCE - 黑暗騎士"   ,product_points: 5880   ,image:"products/helmet.jpg")
Product.create!(name:"鋪棉飛行夾克"   ,product_points: 3490   ,image:"products/clothe.jpg")
Product.create!(name:"越野前貨架"  ,product_points: 4580   ,image:"products/front_rack.jpg")
Product.create!(name:"GOGORO安全帽 競賽風格 - 復刻款(銀)"   ,product_points: 2990   ,image:"products/helmet2.jpg")
Product.create!(name:"反光條紋 女裝T恤"  ,product_points: 690    ,image:"products/tshirt.jpg")
Product.create!(name:"經典鑰匙皮套"   ,product_points: 690    ,image:"products/keyholder.jpg")
Product.create!(name:"GOGORO 2 PEBBLE 多功能風鏡"   ,product_points: 4320   ,image:"products/mirror.jpg")
Product.create!(name:"GOGORO 2 復古造型座墊"   ,product_points: 4980   ,image:"products/seat.jpg")
Product.create!(name:"GOGORO 2 一體成型鋁合金踏墊"   ,product_points: 3390    ,image:"products/floorpad.jpg")

# Repairstore
Repairstore.destroy_all

repairstore_list = [
 {name:"松山饒河店", address: "台北市松山區八德路四段650號", telephone: "0981-186-111",  officehours:"週一至週日 12:30 - 21:00" , repairhours:"週一至週六 12:00 - 21:00 週日公休"},
 {name:"板橋館前店", address: "新北市板橋區館前東路26號", telephone: "0981-070-220",  officehours:"週一至週日 12:00 - 22:00" , repairhours:"週一至週六 12:00 - 21:00 週日公休"},
 {name:"桃園八德店", address: "桃園市八德區介壽路二段312號", telephone: "0981-158-688",  officehours:"週一至週日 11:00 - 21:00" , repairhours:"週一至週六 11:00 - 21:00 週日公休"},
 {name:"新竹北大店", address: "新竹市北區北大路321號", telephone: "0981-166-333",  officehours:"" , repairhours:"週一至週日 12:00 - 21:00"},
 {name:"頭份自強服務中心", address: "苗栗縣頭份市自強路230號2樓", telephone: "0981-070-220",  officehours:"" , repairhours:"週一至週六 12:00 - 21:00 週日公休"},
 {name:"大里德芳服務中心", address: "台中市大里區德芳南路459號", telephone: "0981-686-966",  officehours:"週一至週日 12:00 - 22:00" , repairhours:"週一至週六 12:00 - 21:00 週日公休"},
 {name:"彰化中山店", address: "彰化市中山路二段437號", telephone: "04-7201966",  officehours:"週一至週日 12:00 - 21:00" , repairhours:"週一至週六 12:00 - 21:00 週日公休"},
 {name:"嘉義興業東店", address: "台南市中西區公園路36號", telephone: "0981-167-111",  officehours:"週一至週日 12:00 - 21:00" , repairhours:"週一至週六 12:00 - 21:00 週日公休"},
 {name:"鳳山青年店", address: "高雄市鳳山區青年路二段287號", telephone: "0981-058-333",  officehours:"週一至週日 12:00 - 21:00" , repairhours:"週一至週六 12:00 - 21:00 週日公休"},
 {name:"屏東公園店", address: "屏東市中華路80號", telephone: "08-7338868",  officehours:"週一至週日 12:00 - 21:00" , repairhours:"週一至週六 12:00 - 21:00 週日公休"}
]

 repairstore_list.each do |repairstore|
   Repairstore.create(name: repairstore[:name], address: repairstore[:address], telephone: repairstore[:telephone], officehours: repairstore[:officehours], repairhours: repairstore[:repairhours])
 end
 puts "repairstore created"


# friendly store
Friendlystore.destroy_all

json = JSON.parse(File.read('app/assets/javascripts/friendly_stores.json'))

json['friendly_stores'].each do |data|
  Friendlystore.create!(
    name: data['name'],
    description: data['description'],
    latitude: data['latitude'],
    longitude: data['longitude'],
    discount: data['discount'],
    address: data['address'],
    source_title: data['source_title'],
    source_url: data['source_url'],
    open_time: data['open_time'],
    main_photo: data['main_photo']
  )
end

puts "have created friendly stores!"
puts "now you have #{Friendlystore.count} friendly stores!"


# task create_trip: :environment do
Trip.destroy_all

# --- 20km
Trip.create!(id: 1, name: "台北逛夜市", image: File.open(Rails.root.join("public/apple-touch-icon.png")),
             description: "別管晚上吃什麼，到夜市再說吧!找到散佈在台北的六大夜市，肚子吃飽，電池充飽飽!")

# --- 60km
Trip.create!(id: 2, name: "新竹東西南北", image: File.open(Rails.root.join("public/apple-touch-icon.png")),
             description: "誰說打麻將只能在桌上打?你也可以一邊騎gogoro，一邊打麻將，趕快搜集完所有東南西北Gostation，看誰先糊牌!")

# --- 20km
Trip.create!(id: 3, name: "大口吃牛肉", image: File.open(Rails.root.join("public/apple-touch-icon.png")),
             description: "你敢挑戰，每天吃牛肉麵嗎?還是挑戰一天吃完5家牛肉麵?快點查查，到底是哪些牛肉麵隱藏在Gostation旁邊吧!別忘了打卡上傳照片，告訴我們你完成了哪一種挑戰吧")

# --- 30km
Trip.create!(id: 4, name: "孤單終結", image: File.open(Rails.root.join("public/apple-touch-icon.png")),
             description: "跟著Gogoro 的腳步，讓全台最靈驗的月老，幫你牽起那條看不見紅線，不管是戀人未滿，還是友達以上，你再也不孤單!")

# --- 50km
Trip.create!(id: 5, name: "北海小英雄", image: File.open(Rails.root.join("public/apple-touch-icon.png")),
             description: "Gogoro 英雄們，一起征服北海岸吧!不管你是誰?今天你就是「北海小英雄」，航行了一整天，別忘了尉勞自己，在北投泡個溫泉，最後在全台灣最大的士林夜市，大口吃雞排吧!")

# --- 60km
Trip.create!(id: 6, name: "台南直直去", image: File.open(Rails.root.join("public/apple-touch-icon.png")),
             description: "歷史幽久的台南古城，除了道地的古早味，還有希臘城堡般的建築等著你，和三五好友來趟文化之旅，一起一探就竟，蹦出新滋味吧!")


gostation_list = [
                    ["台北捷運劍潭站", "台北捷運民權西路站", "中油信義路加油站",
                     "Gogoro 饒河服務中心站", "Gogoro 師大和平店站A", "康定路機車停車場站"],

                    ["中油竹東加油站", "中油關西加油站", "中油南寮加油站", "中油竹北加油站",
                     "Gogoro 新竹北大店站"],

                    ["Gogoro 師大和平店站A", "中油內湖加油站", "中油新生北路加油站",
                     "Gogoro 信義松仁授權服務中心站", "中油中崙加油站"],

                    ["先奕實業站", "便利停車場建國站", "艋舺公園地下停車場站",
                     "台塑政大加油站", "台北捷運唭哩岸站"],

                    ["中油石門加油站", "中油大嘉好加油站", "台北捷運淡水站",
                     "北投熱海溫泉大飯店站", "中油福林加油站"],

                    ["7-ELEVEN 安安店站", "善化國小站", "7-ELEVEN 仁伯店站",
                     "全聯台南明興店站", "Gogoro 台南公園店站"]#,
                 ]

idx = 0
Trip.all.each do |t|
  t.gostations_index = []
  gostation_list[idx].each do |g|
    t.gostations_index.push(Gostation.where(LocName: g).first.id)
  end
  t.save
  idx = idx + 1
end
puts "have created trips!"
puts "now you have #{Trip.count} trips data!"


TripGostation.destroy_all
Trip.all.each do |t|
  t.gostations_index.each do |gid|
    User.all.each do |u|
      TripGostation.create!(
        user_id: u.id,
        trip_id: t.id,
        gostation_id: gid,
        status: false
      )
    end
  end
end

puts "have created fake TripGostations!"
puts "now you have #{TripGostation.count} TripGostations data!"

