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

  # task parse_gostation_list_v2: :environment do
  #   Gostation.destroy_all

  #   url = 'https://webapi.gogoro.com/api/vm/list'
  #   uri = URI(url)
  #   response = Net::HTTP.get(uri)
  #   json = JSON.parse(response)

  #   json.each do |data|
  #     Gostation.create!(
  #       LocName:       find_zh_TW( JSON.parse(data['LocName']) ),
  #       Latitude:      data['Latitude'],
  #       Longitude:     data['Longitude'],
  #       ZipCode:       data['ZipCode'],
  #       Address:       find_zh_TW( JSON.parse(data['Address']) ),
  #       District:      find_zh_TW( JSON.parse(data['District']) ),
  #       City:          find_zh_TW( JSON.parse(data['City']) ),
  #       AvailableTime: '24HR',
  #       StorePhoto:    data['StorePhoto'][0],
  #       BatteryCells:  rand(1..4)*8
  #     )
  #   end

  #   puts "have created gostations!"
  #   puts "now you have #{Gostation.count} gostations!"
  # end

  # task parse_friendly_stores: :environment do
  #   Friendlystore.destroy_all

  #   json = JSON.parse(File.read('app/assets/javascripts/friendly_stores.json'))

  #   json['friendly_stores'].each do |data|
  #     Friendlystore.create!(
  #       name: data['name'],
  #       description: data['description'],
  #       latitude: data['latitude'],
  #       longitude: data['longitude'],
  #       discount: data['discount'],
  #       address: data['address'],
  #       source_title: data['source_title'],
  #       source_url: data['source_url'],
  #       open_time: data['open_time'],
  #       main_photo: data['main_photo']
  #     )
  #   end

  #   puts "have created friendly stores!"
  #   puts "now you have #{Friendlystore.count} friendly stores!"
  # end

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

  # task create_trip: :environment do
  #   Trip.destroy_all

  #   Trip.create!(name: "台北逛夜市")
  #   Trip.create!(name: "新竹東西南北")
  #   Trip.create!(name: "大口吃牛肉")
  #   Trip.create!(name: "孤單終結")
  #   Trip.create!(name: "北海小英雄")
  #   Trip.create!(name: "台南直直撞")
  #   Trip.create!(name: "高雄龍兄虎弟")

  #   gostation_list = [
  #                       ["台北捷運劍潭站", "台北捷運民權西路站", "中油信義路加油站",
  #                        "Gogoro 饒河服務中心站", "Gogoro 師大和平店站A", "康定路機車停車場站"],

  #                       ["中油竹東加油站", "中油關西加油站", "中油南寮加油站", "中油竹北加油站",
  #                        "Gogoro 新竹北大店站"],

  #                       ["Gogoro 師大和平店站A", "中油內湖加油站", "中油新生北路加油站",
  #                        "Gogoro 信義松仁授權服務中心站", "中油中崙加油站"],

  #                       ["先奕實業站", "便利停車場建國站", "艋舺公園地下停車場站",
  #                        "台塑政大加油站", "中油振興路加油站"],

  #                       ["中油石門加油站", "中油大嘉好加油站", "台北捷運淡水站",
  #                        "台北捷運民權西路站", "中油信義路加油站"],

  #                       ["7-ELEVEN 安安店站", "善化國小站", "7-ELEVEN 仁伯店站",
  #                        "全聯台南明興店站", "Gogoro 台南公園店站"],

  #                       ["中油軍校路加油站", "中油九曲堂加油站", "中油小港加油站",
  #                        "中油旗津加油站", "九號倉會館站"]
  #                    ]

  #   idx = 0
  #   Trip.all.each do |t|
  #     t.gostations_index = []

  #     gostation_list[idx].each do |g|
  #       t.gostations_index.push(Gostation.where(LocName: g).first.id)
  #     end
  #     t.save
  #     idx = idx + 1
  #   end

  #   puts "have created trips!"
  #   puts "now you have #{Trip.count} trips data!"
  # end

  # task create_trip_gostation: :environment do
  #   TripGostation.destroy_all
  #   Trip.all.each do |t|
  #     t.gostations_index.each do |gid|
  #       User.all.each do |u|
  #         TripGostation.create!(
  #           user_id: u.id,
  #           trip_id: t.id,
  #           gostation_id: gid,
  #           status: false
  #         )
  #       end
  #     end
  #   end


  #   puts "have created fake TripGostations!"
  #   puts "now you have #{TripGostation.count} TripGostations data!"
  # end

  task fake_point: :environment do
    User.all.each do |t|
      t.add_points(rand(1..500), category: 'fake')

    end

    puts "have created fake points"
  end

  task create_site_info: :environment do
    Site.destroy_all

    # --- trip 1
    Site.create!(name: "士林夜市", latitude: 25.087868, longitude: 121.524077, trip_id: 1,
                 description: "士林夜市是臺北市範圍最大的夜市，也是國外觀光客造訪臺北必到的觀光夜市，走一趟士林，各種一網打盡各種好吃好玩的。不要錯過香噴噴的「豪大大雞排」外脆內嫩，搭配一杯好喝的「青蛙下蛋」和香氣四溢的「士林大香腸」，現在就出發士林夜市，解放你的味蕾吧。", photo: "challenges/Market/1.jpg");
    Site.create!(name: "寧夏夜市", latitude: 25.056853, longitude: 121.515545, trip_id: 1,
                 description: "寧夏夜市冷知識，你知道小小一條街的寧夏夜市，其是大有來頭?打敗眾多夜市，在台北市政府舉辦「臺北夜市之最」投票選舉，寧夏夜市於夜市主題中奪得「最好逛夜市」、「最美味夜市」、「最有魅力夜市」、「最環保夜市」及「最友善夜市」冠軍?倒底是什麼樣的魅力?快點一探就竟吧!(p.s不要錯過大排長龍的芋泥球喔)",photo: "challenges/Market/2.jpg");
    Site.create!(name: "臨江夜市", latitude: 25.030280, longitude: 121.554239, trip_id: 1,
                 description: "聽過臨江夜市嗎?不想和觀光客人擠人?只有在地人才知道的臨江夜市，絕對是你的好選擇。這裡的青島豆漿，愛玉之夢遊仙草，是你在其它夜市找不到的好口味!逛完夜市，腳痛腿麻了?別忘了對自己好一點，試試臨江夜市最有名的腳底按摩!",photo: "challenges/Market/3.jpg");
    Site.create!(name: "饒河街夜市", latitude: 25.050906, longitude: 121.577648, trip_id: 1,
                 description: "說到饒河街夜市，可不能只有逛夜市喔!一定要一訪有近260年歷史，香火鼎盛的「慈祐宮」，好好欣賞古老建築在晚上燈光映照下的曚朧之美，除了古老的廟宇，還要一訪曾經入選世界最美20 大書局的「蔦屋書店二號店」，更重要的是別忘了來gogoro 松山饒河門市分享你今天的旅程喔!",photo: "challenges/Market/4.jpg");
    Site.create!(name: "師大夜市", latitude: 25.024542, longitude: 121.529366, trip_id: 1,
                 description: "位於師範大學旁的師大夜市，除了吃的，有保證全台灣最便宜的書局，還有最多的是與韓國連線的時尚服飾，想要走在時尚前線的你，不能不到師大夜市搭配自己的專屬時尚喔!打卡上傳你的時尚LOOK吧!",photo: "challenges/Market/5.jpg");
    Site.create!(name: "華西街夜市", latitude: 25.038599, longitude: 121.498443, trip_id: 1,
                 description: "位於萬華區的華西街夜市，緊臨龍山寺、剝皮寮，青草巷，讓你有種回到過去的錯覺，這樣的魅力也是吸引電影「艋舺」以這個地方為主題拍片的原因喔!想要感受老台北的風光年華，來趟猛舺之旅，再挑戰以華西街夜市的神秘料理化下句點吧!",photo: "challenges/Market/6.jpg");

    # --- trip 2
    Site.create!(name: "寶山水庫", latitude: 24.752685, longitude: 121.045577, trip_id: 2,
                 description: "到新竹除了到北埔吃客家美食，還可以到寶山水庫一覽湖水風光!沿著環湖步道走走，還會發現美麗的吊橋喔!這個秘密景點是竹科新貴，假日充電的好所在!到水庫前別忘了在充電站打卡換電池喔!",photo: "challenges/Hsinchu/1.jpeg");
    Site.create!(name: "牛欄河親水公園", latitude: 24.792248, longitude: 121.180862, trip_id: 2,
                 description: "不只宜蘭有親水公園，在新竹也有個牛欄河親水公園，利用週末穿著夾腳拖，去趟親水公園泡泡腳，其中還有「我的少女時代」的場景喔!快點找找場景在哪裡，拍下你的完美角度吧!",photo: "challenges/Hsinchu/2.jpg");
    Site.create!(name: "南寮漁港", latitude: 24.849806, longitude: 120.929003, trip_id: 2,
                 description: "到南寮吹海風，吃海鮮，還有一片大綠地，適合帶家裡的毛小孩出來放風溜一溜喔!拍下你家毛小孩開心的照片，上傳分享吧!",photo: "challenges/Hsinchu/3.jpg");
    Site.create!(name: "頭前溪豆腐岩", latitude: 24.799891, longitude: 121.029656, trip_id: 2,
                 description: "你知道新竹有美麗的豆腐岩嗎?在市區就能聽到流水的聲音，洗掉平日的疲勞，帶著咖啡，輕食，一起享受午後的悠閒吧!對了，愛拍照的你，別忘了帶上單眼和角架，絕對能拍到必勝照片喔!",photo: "challenges/Hsinchu/4.jpg");
    Site.create!(name: "城隍廟", latitude: 24.804244, longitude: 120.966147, trip_id: 2,
                 description: "來新竹必到的打卡景點:城隍廟夜市，除了吃好吃的新竹貢丸，米粉，肉圓，別忘了回家前在廟口試試手氣，買張樂透吧!",photo: "challenges/Hsinchu/5.jpg");

    # --- trip 3
    Site.create!(name: "永康牛肉麵", latitude: 25.032912, longitude: 121.528107, trip_id: 3,
                 description: "位於台北市的永康牛肉麵最早發跡於永康公園旁的小牛肉麵攤，已經有五十幾年的歷史了喔!川味道地的牛肉麵，愛吃的你，趕快去嘗嘗!",photo: "challenges/Beefnoodle/1.jpg");
    Site.create!(name: "牛爸爸牛肉麵", latitude: 25.068905, longitude: 121.594530, trip_id: 3,
                 description: "牛肉麵不只是小吃，也能做的跟法式料理一樣精緻喔!老閭以目標  碗碗世界第一，這樣的決心來做牛肉麵，值得大家試試不一樣的味道!",photo: "challenges/Beefnoodle/2.jpg");
    Site.create!(name: "史記牛肉麵", latitude: 25.057872, longitude: 121.529621, trip_id: 3,
                 description: "吃貳了紅燒口味嗎，史記牛肉麵有名的清燉牛肉麵是你的不二選擇，有如助骨拉麵般的乳白色湯頭 ，吃了脣齒留香，讓人還想再來一碗，吃完牛肉麵想要消化一下走一走可以到有名的行天宮朝聖喔!",photo: "challenges/Beefnoodle/3.jpg");
    Site.create!(name: "穆記牛肉麵", latitude: 25.027460, longitude: 121.563385, trip_id: 3,
                 description: "不說你可能不知道，傳說中台北牛肉麵節的發想就是起源於穆記喔!讓街坊一吃再吃的好味道，同時也深受政商名流的喜愛 。gogoro文青們吃完牛肉麵可以到旁邊的「四四南村」，趟在草皮上欣賞101夜景喔!",photo: "challenges/Beefnoodle/4.jpg");
    Site.create!(name: "林東芳牛肉麵", latitude: 25.046479, longitude: 121.541711, trip_id: 3,
                 description: "你是夜貓族嗎?跑趴一族?還是辛苦的服務業，晚班下班找不到東西吃，沒關係到林東芳就對了，營業時間到零晨四點，別再說半夜只能吃7-11了 ，專屬台灣的人情味，半夜也能吃到一晚熱熱的牛肉麵，溫暖你的胃，也溫暖你的心!",photo: "challenges/Beefnoodle/5.jpg");

    # --- trip 4
    Site.create!(name: "霞海城隍廟", latitude: 25.055609, longitude: 121.510162, trip_id: 4,
                 description: "位於台灣台北市大同區迪化街上，是台北市的直轄市定古蹟。。這裡最有名的是祈求好姻緣，看到廟裡信徒回贈的喜餅就知道，這裡不是浪得虛名喔 ，把這裡做為終結孤單的起點吧!",photo: "challenges/Temple/1.jpg");
    Site.create!(name: "四面佛", latitude: 25.054424, longitude: 121.533588, trip_id: 4,
                 description: "傳說中長春四面佛特別靈驗，參拜時間是  24小時，所以半夜覺得空虛寂莫冷的時候，可以騎著你的gogoro來求一段好姻緣!",photo: "challenges/Temple/2.jpg");
    Site.create!(name: "龍山寺", latitude: 25.037162, longitude: 121.499901, trip_id: 4,
                 description: "龍山寺為國家保護之二級古蹟，與國立故宮博物院、中正紀念堂並列為國際觀光客來臺旅遊的三大名勝，大家不知道其實這裡的月老很靈驗，就連電影大明星也都慕名來參拜，而且順利找到另一伴囉!你還在等什麼呢?現在就騎著gogoro找到你的另一伴吧!",photo: "challenges/Temple/3.jpg");
    Site.create!(name: "指南宮", latitude: 24.979824, longitude: 121.586626, trip_id: 4,
                 description: "到木柵，坐覽車，看企鵝，喝茶賞月亮，還可以幹什麼?你還可以走訪指南宮，偷偷告訴月老你的理想型，讓他幫你牽紅線喔!事不宜遲，現在就出發告訴月老去!",photo: "challenges/Temple/4.jpg");
    Site.create!(name: "照明淨寺", latitude: 25.131610, longitude: 121.513813, trip_id: 4,
                 description: "又稱情人廟，為於北投，座落於北投軍艦岩前之山坡上，四面環山，環境清幽，視野開闊，向前可以看到關渡平原，站在此地向前遠眺關渡平原，是一處環境幽雅，景色怡人的去處。 到北投除了踏青、泡溫溫泉，還可以到情人廟，做為終結孤單最後一站!",photo: "challenges/Temple/5.jpg");

    # --- trip 5
    Site.create!(name: "老梅綠石槽", latitude: 25.292095, longitude: 121.545457, trip_id: 5,
                 description: "位於北海岸石門區老梅里的綠石槽海岸，為全台唯一特殊景觀，綠石槽只出現在四、五月份，隨後海藻就在夏日陽光的曝曬下而消失，這段短暫而美麗的季節中，你還在等什麼呢?現在就接受挑戰吧!",photo: "challenges/Northshore/1.jpeg");
    Site.create!(name: "淺水灣", latitude: 25.251475, longitude: 121.469913, trip_id: 5,
                 description: "三芝的淺水灣就像台北的峇里島，來到三芝除了曬太陽，享受海風，還可以選家喜歡的露天咖啡店，聽聽Live演唱，會更有情調喔!上傳照片告訴我們你去了哪裡吧!",photo: "challenges/Northshore/2.jpg");
    Site.create!(name: "淡水紅毛城", latitude: 25.175435, longitude: 121.432942, trip_id: 5,
                 description: "你還記得歷史課本裡的紅毛城嗎?現在還搞不清楚，到底是西班牙人建的，還是葡萄牙人建的嗎?在淡水除了有紅毛城，還有小白宮，滬尾偕醫館等等洋樓風格的建築喔!不知道還以為到了歐洲一趟了呢!走!今天就出發去歐洲!",photo: "challenges/Northshore/3.jpg");
    Site.create!(name: "北投溫泉博物館", latitude: 25.136577, longitude: 121.507154, trip_id: 5,
                 description: "到北投泡湯，卻不知道北投泡湯的歷史?你知道北投溫泉博物館前身是東亞最大的溫泉公共浴場? 整個北投都是我家的浴室(誤)?博物館由圓拱列柱圍起的羅馬風格大浴池，以及浴池外側迴廊牆上的鑲嵌彩繪玻璃窗花，讓你有穿越時穿的錯覺，現在就去體驗北投版的羅馬浴場吧!",photo: "challenges/Northshore/4.jpg");
    Site.create!(name: "士林夜市", latitude: 25.087868, longitude: 121.524077, trip_id: 5,
                 description: "士林夜市是臺北市範圍最大的夜市，也是國外觀光客造訪臺北必到的觀光夜市，走一趟士林，各種一網打盡各種好吃好玩的。不要錯過香噴噴的「豪大大雞排」外脆內嫩，搭配一杯好喝的「青蛙下蛋」和香氣四溢的「士林大香腸」，現在就出發士林夜市，解放你的味蕾吧。",photo: "challenges/Northshore/5.jpg");

    # --- trip 6
    Site.create!(name: "四色草隧道", latitude: 23.019634, longitude: 120.136141, trip_id: 6,
                 description: "四色草隧道是台版的「亞馬遜河」喔!沒去過亞馬遜，但你可以來四色草隧道!到這裡要先把gogoro停一邊，換上救生衣，坐船出發體驗去!",photo: "challenges/Tainan/1.jpg");
    Site.create!(name: "幾米主題公園", latitude: 23.108510, longitude: 120.270209, trip_id: 6,
                 description: "在台南科學園區的各個角落，有著幾米繪本裡的可愛場景和角色喔!你知道總共藏著幾隻貓嗎?快去算一算吧!把你的答案留在下面!",photo: "challenges/Tainan/2.jpg");
    Site.create!(name: "奇美博物館", latitude: 22.934783, longitude: 120.226068, trip_id: 6,
                 description: "到台南不能只能顧著吃小吃，還要來一趟文化的享宴，奇美博物館座落台南都會公園，是台南必到打卡景點，就像到英國，要去白金漢宮，到法國要到凡爾賽宮，到台南就要到奇美博物館，感受不輸國外的氛圍吧!",photo: "challenges/Tainan/3.jpg");
    Site.create!(name: "黃金海岸", latitude: 22.933209, longitude: 120.176258, trip_id: 6,
                 description: "台南原來離海那麼近?在市區玩膩了，就出發到黃金海岸吧!黃昏的時候一望無垠的海岸，被夕陽染紅，走在閃閃發光的沙灘上，非常浪漫喔!",photo: "challenges/Tainan/4.jpg");
    Site.create!(name: "赤崁樓", latitude: 22.997478, longitude: 120.202543, trip_id: 6,
                 description: "充滿歷史的建築，先後經歷荷蘭人，鄭氏時期………用說的不如親自去瞧瞧吧!逛玩了以後別忘了吃有名的武廟肉圓，為自己的肚子充充電，當然也要為gogoro充充電喔 !",photo: "challenges/Tainan/5.jpg");
  
    puts "have created gostation sites!"
    puts "now you have #{Site.count} gostation sites!"
  end


end