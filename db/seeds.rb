# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'ffaker'

#User
# Default admin
    User.destroy_all

    User.create!(
      name: "adminuser", email: "admin@example.com", password: "123456", role: "admin"
      )
    puts "Default admin created!"
    
    30.times do |i|
      user_name = FFaker::Name.first_name
      User.create!(email: "#{user_name}@example.com", password: "123456", name: "#{user_name}")
    end
    puts "now you have #{User.count} users data!"


    Followship.destroy_all

    User.all.each do |user|
      User.all.sample(10) do |u|
        user.followships.create!(following_id: u.id)
        #puts "followships created"
      end
      puts "#{User.count} user's followships created"
    end

    Checkin.destroy_all

    User.all.each do |user|
      10.times do |i|
        random_gostation = rand(Gostation.first.id..Gostation.last.id)
        user.checkins.create!(gostation_id: random_gostation)
      end
      puts "#{Checkin.count} checkins created"
    end
# Products
   Products.destroy_all
 
   Product.create!(name:"GOGORO 安全帽 S PERFORMANCE - 黑暗騎士"   ,product_points: 5880   ,image:"products/helmet.jpg")
   Product.create!(name:"鋪棉飛行夾克"   ,product_points: 3490   ,image:"products/clothe.jpg")
   Product.create!(name:"越野前貨架"  ,product_points: 4580   ,image:"products/front_rack.jpg")
   Product.create!(name:"GOGORO安全帽 競賽風格 - 復刻款(銀)"   ,product_points: 2990   ,image:"products/helmet2.jpg")
   Product.create!(name:"反光條紋 女裝T恤"  ,product_points: 690    ,image:"products/tshirt.jpg")
   Product.create!(name:"經典鑰匙皮套"   ,product_points: 690    ,image:"products/keyholder.jpg")
    Product.create!(name:"GOGORO 2 PEBBLE 多功能風鏡"   ,product_points: 4320   ,image:"products/mirror.jpg")
     Product.create!(name:"GOGORO 2 復古造型座墊"   ,product_points: 4980   ,image:"products/seat.jpg")
      Product.create!(name:"GOGORO 2 一體成型鋁合金踏墊"   ,product_points: 3390    ,image:"products/floorpad.jpg")
#  task parse_gostation_list_v2: :environment do
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
#  end

#  task parse_friendly_stores: :environment do
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
#  end

# task create_trip: :environment do
    Trip.destroy_all

    Trip.create!(id: 1, name: "台北逛夜市", image: File.open(Rails.root.join("public/apple-touch-icon.png")),
                 description: "別管晚上吃什麼，到夜市再說吧!找到散佈在台北的六大夜市，肚子吃飽，電池充飽飽!")
    Trip.create!(id: 2, name: "新竹東西南北", image: File.open(Rails.root.join("public/apple-touch-icon.png")),
                 description: "誰說打麻將只能在桌上打?你也可以一邊騎gogoro，一邊打麻將，趕快搜集完所有東南西北Gostation，看誰先糊牌!")
    Trip.create!(id: 3, name: "大口吃牛肉", image: File.open(Rails.root.join("public/apple-touch-icon.png")),
                 description: "你敢挑戰，每天吃牛肉麵嗎?還是挑戰一天吃完5家牛肉麵?快點查查，到底是哪些牛肉麵隱藏在Gostation旁邊吧!別忘了打卡上傳照片，告訴我們你完成了哪一種挑戰吧")
    Trip.create!(id: 4, name: "孤單終結", image: File.open(Rails.root.join("public/apple-touch-icon.png")),
                 description: "跟著Gogoro 的腳步，讓全台最靈驗的月老，幫你牽起那條看不見紅線，不管是戀人未滿，還是友達以上，你再也不孤單!")
    Trip.create!(id: 5, name: "北海小英雄", image: File.open(Rails.root.join("public/apple-touch-icon.png")),
                 description: "Gogoro 英雄們，一起征服北海岸吧!不管你是誰?今天你就是「北海小英雄」，航行了一整天，別忘了尉勞自己，在北投泡個溫泉，最後在全台灣最大的士林夜市，大口吃雞排吧!")
    Trip.create!(id: 6, name: "台南直直去", image: File.open(Rails.root.join("public/apple-touch-icon.png")),
                 description: "歷史幽久的台南古城，除了道地的古早味，還有希臘城堡般的建築等著你，和三五好友來趟文化之旅，一起一探就竟，蹦出新滋味吧!")
    #Trip.create!(name: "高雄龍兄虎弟", image: File.open(Rails.root.join("public/apple-touch-icon.png")), description: "123")

    gostation_list = [
                        ["台北捷運劍潭站", "台北捷運民權西路站", "中油信義路加油站",
                         "Gogoro 饒河服務中心站", "Gogoro 師大和平店站A", "康定路機車停車場站"],

                        ["中油竹東加油站", "中油關西加油站", "中油南寮加油站", "中油竹北加油站",
                         "Gogoro 新竹北大店站"],

                        ["Gogoro 師大和平店站A", "中油內湖加油站", "中油新生北路加油站",
                         "Gogoro 信義松仁授權服務中心站", "中油中崙加油站"],

                        ["先奕實業站", "便利停車場建國站", "艋舺公園地下停車場站",
                         "台塑政大加油站", "中油振興路加油站"],

                        ["中油石門加油站", "中油大嘉好加油站", "台北捷運淡水站",
                         "台北捷運民權西路站", "中油信義路加油站"],

                        ["7-ELEVEN 安安店站", "善化國小站", "7-ELEVEN 仁伯店站",
                         "全聯台南明興店站", "Gogoro 台南公園店站"]#,
                     ]
                    #    ["中油軍校路加油站", "中油九曲堂加油站", "中油小港加油站",
                    #     "中油旗津加油站", "九號倉會館站"]
                    # ]

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
 # end

   # task create_trip_gostation: :environment do
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
 # end

