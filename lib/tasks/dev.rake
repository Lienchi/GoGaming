require 'net/http'

def find_zh_TW(list)
  list['List'].each do |data|
    if data['Lang'] == 'zh-TW'
      return data['Value']
    end
  end
  return 'Unknown'
end

namespace :dev do
  task parse_gostation_list_v1: :environment do
    Gostation.destroy_all

    url = 'https://wapi.gogoro.com/tw/api/vm/list'
    uri = URI(url)
    response = Net::HTTP.get(uri)
    json = JSON.parse(response)

    json['data'].each do |data|
      Gostation.create!(
        LocName:       find_zh_TW( JSON.parse(data['LocName']) ),
        Latitude:      data['Latitude'],
        Longitude:     data['Longitude'],
        ZipCode:       data['ZipCode'],
        Address:       find_zh_TW( JSON.parse(data['Address']) ),
        District:      find_zh_TW( JSON.parse(data['District']) ),
        City:          find_zh_TW( JSON.parse(data['City']) ),
        AvailableTime: data['AvailableTime']
      )
    end

    puts "have created gostations!"
    puts "now you have #{Gostation.count} gostations!"
  end

  task parse_gostation_list_v2: :environment do
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
  end

  task parse_friendly_stores: :environment do
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
  end

  task fake_user: :environment do
    User.destroy_all

    User.create!(
      email: "root@example.com",
      password: "123456",
      role: "admin"
    )
    20.times do |i|
      User.create!(
        email: "user#{i}@example.com",
        password: "123456"
      )
    end
    puts "have created admin and fake users!"
    puts "now you have #{User.count} users data!"
  end

  task fake_trip: :environment do
    Trip.destroy_all

    Trip.create!(name: "新竹城隍廟")
    Trip.create!(name: "桃園虎頭山")
    Trip.create!(name: "台中文青之旅")
    Trip.create!(name: "高雄港都之戀")
    Trip.create!(name: "基隆北海岸")

    Trip.all.each do |t|
      t.stations = []

      
    end

    Trip.all.each do |t|
      t.gostations_index = []
      gostations = Gostation.all.sample(5);
      5.times do |i|
        t.gostations_index[i] = gostations[i].id
      end
      t.save
    end

    puts "have created trips!"
    puts "now you have #{Trip.count} trips data!"
  end

  task fake_trip_gostation: :environment do
    TripGostation.destroy_all
    Trip.all.each do |t|
      Gostation.all.sample(5).each do |g|
        User.all.each do |u|
          TripGostation.create!(
            user_id: u.id,
            trip_id: t.id,
            gostation_id: g.id,
            status: false
          )
        end
      end
    end


    puts "have created fake TripGostations!"
    puts "now you have #{TripGostation.count} TripGostations data!"
  end

  task create_trip: :environment do
    Trip.destroy_all

    Trip.create!(name: "台北逛夜市")
    Trip.create!(name: "新竹東西南北")
    Trip.create!(name: "大口吃牛肉")
    Trip.create!(name: "孤單終結")
    Trip.create!(name: "北海小英雄")
    Trip.create!(name: "台南直直撞")
    Trip.create!(name: "高雄龍兄虎弟")

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
  end

  task create_trip_gostation: :environment do
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
  end

  task fake_point: :environment do
    User.all.each do |t|
      t.add_points(rand(1..500), category: 'fake')

    end

    puts "have created fake points"
  end


end