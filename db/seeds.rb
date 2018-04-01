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
      10.times do |i|
        fake_following = User.first.id + i
        user.followships.create!(following_id: User.first.id + i)
        puts "followships created"
      end
      puts "#{User.count} user's followships created"
    end

    Checkin.destroy_all

    Gostation.all.each do |gostation|
      10.times do |i|
        random_user = rand(User.first.id..User.last.id)
        gostation.checkins.create!(user_id: random_user)
      end
    end
    
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

    Trip.create!(name: "台北逛夜市", image: File.open(Rails.root.join("public/apple-touch-icon.png")), description: "123")
    Trip.create!(name: "新竹東西南北", image: File.open(Rails.root.join("public/apple-touch-icon.png")), description: "123")
    Trip.create!(name: "大口吃牛肉", image: File.open(Rails.root.join("public/apple-touch-icon.png")), description: "123")
    Trip.create!(name: "孤單終結", image: File.open(Rails.root.join("public/apple-touch-icon.png")), description: "123")
    Trip.create!(name: "北海小英雄", image: File.open(Rails.root.join("public/apple-touch-icon.png")), description: "123")
    Trip.create!(name: "台南直直去", image: File.open(Rails.root.join("public/apple-touch-icon.png")), description: "123")
    Trip.create!(name: "高雄龍兄虎弟", image: File.open(Rails.root.join("public/apple-touch-icon.png")), description: "123")

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
                         "全聯台南明興店站", "Gogoro 台南公園店站"],

                        ["中油軍校路加油站", "中油九曲堂加油站", "中油小港加油站",
                         "中油旗津加油站", "九號倉會館站"]
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

