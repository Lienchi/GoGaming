# Use this hook to configure merit parameters
Merit.setup do |config|
  # Check rules on each request or in background
  # config.checks_on_each_request = true

  # Define ORM. Could be :active_record (default) and :mongoid
  # config.orm = :active_record

  # Add application observers to get notifications when reputation changes.
  # config.add_observer 'MyObserverClassName'

  # Define :user_model_name. This model will be used to grand badge if no
  # `:to` option is given. Default is 'User'.
  # config.user_model_name = 'User'

  # Define :current_user_method. Similar to previous option. It will be used
  # to retrieve :user_model_name object if no `:to` option is given. Default
  # is "current_#{user_model_name.downcase}".
  # config.current_user_method = 'current_user'
end

# Create application badges (uses https://github.com/norman/ambry)
# badge_id = 0
# [{
#   id: (badge_id = badge_id+1),
#   name: 'just-registered'
# }, {
#   id: (badge_id = badge_id+1),
#   name: 'best-unicorn',
#   custom_fields: { category: 'fantasy' }
# }].each do |attrs|
#   Merit::Badge.create! attrs
# end




Merit::Badge.create!(
  id: 1,
  name: "Taipei_night_market",
  description: "台北夜市達人",
  level: "1",
  custom_fields: { image: "badges/Taipei_night_market.svg"}
)


Merit::Badge.create!(
  id: 2,
  name: "Hsinchu",
  description: "環遊新竹",
  level: "1",
  custom_fields: { image: "badges/Hsinchu.svg"}
)


Merit::Badge.create!(
  id: 3,
  name: "Taipei_beef_noodle",
  description: "台北牛人",
  level: "1",
  custom_fields: { image: "badges/Taipei_beef_noodle.svg"}
)


Merit::Badge.create!(
  id: 4,
  name: "Temple_love",
  description: "好姻緣",
  level: "1",
  custom_fields: { image: "badges/Temple_love.svg"}
)


Merit::Badge.create!(
  id: 5,
  name: "North_shore",
  description: "北海小英雄",
  level: "1",
  custom_fields: { image: "badges/North_shore.svg"}
)

Merit::Badge.create!(
  id: 6,
  name: "Tainan",
  description: "台南文青",
  level: "1",
  custom_fields: { image: "badges/Tainan.svg"}
)

Merit::Badge.create!(
  id: 101,
  name: "just-registered",
  description: "新手上路",
  level: "1",
  custom_fields: { image: "badges/just-registered.svg", img_url: "http://blog.gogoro.com/hubfs/1-Taiwan_Blog_(08.11_onwards)/Community/Badge/Irongofans/1_newbie_l_696_696-01.svg"}
  )

Merit::Badge.create!(
  id: 102,
  name: "check-out-trip",
  description: "挑戰任務",
  level: "1",
  custom_fields: { image: "badges/check-out-trip.svg", img_url: "http://blog.gogoro.com/hubfs/1-Taiwan_Blog_(08.11_onwards)/Community/Badge/Irongofans/1_newbie_l_696_696-01.svg"}
)

Merit::Badge.create!(
  id: 103,
  name: "check-gostation",
  description: "踏上旅程",
  level: "1",
  custom_fields: { image: "badges/check-gostation.svg", img_url: "http://blog.gogoro.com/hubfs/1-Taiwan_Blog_(08.11_onwards)/Community/Badge/Irongofans/1_newbie_l_696_696-01.svg"}

)
