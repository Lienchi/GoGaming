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
      password: "123456"
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

  task fake_point: :environment do
    User.all.each do |t|
      t.add_points(rand(1..500), category: 'fake')

    end

    puts "have created fake points"
  end


end