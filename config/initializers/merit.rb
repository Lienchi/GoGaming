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
  name: "just-registered",
  description: "新手上路",
  level: "1",
  custom_fields: { img_url: "http://blog.gogoro.com/hubfs/1-Taiwan_Blog_(08.11_onwards)/Community/Badge/Irongofans/1_newbie_l_696_696-01.svg"}
)


Merit::Badge.create!(
  id: 2,
  name: "love-Hsinchu",
  description: "就是愛新竹",
  level: "1",
  custom_fields: { img_url: "https://blog.gogoro.com/hubfs/1-Taiwan_Blog_(08.11_onwards)/Community/Badge/Lovegogoro/186_hsinchu_l_696_696-01.svg?t=1520994640085"}
)


Merit::Badge.create!(
  id: 3,
  name: "love-Taoyuan",
  description: "就是愛桃園",
  level: "1",
  custom_fields: { img_url: "https://blog.gogoro.com/hubfs/1-Taiwan_Blog_(08.11_onwards)/Community/Badge/Lovegogoro/181_love_taoyuan_l_696_696-01.svg?t=1520994640085"}
)


Merit::Badge.create!(
  id: 4,
  name: "love-Taichung",
  description: "就是愛台中",
  level: "1",
  custom_fields: { img_url: "https://blog.gogoro.com/hubfs/1-Taiwan_Blog_(08.11_onwards)/Community/Badge/Lovegogoro/191_taichung_l_696_696-01.svg?t=1520994640085"}
)


Merit::Badge.create!(
  id: 5,
  name: "love-Kaohsiung",
  description: "就是愛港都",
  level: "1",
  custom_fields: { img_url: "https://blog.gogoro.com/hubfs/1-Taiwan_Blog_(08.11_onwards)/Community/Badge/Lovegogoro/200_kaohsiung_l_696_696-01.svg?t=1520994640085"}
)


Merit::Badge.create!(
  id: 6,
  name: "love-happy",
  description: "超開薰",
  level: "1",
  custom_fields: { img_url: "https://blog.gogoro.com/hubfs/1-Taiwan_Blog_(08.11_onwards)/Community/Badge/Lovegogoro/206_ridetogether_l_696_696-01.svg?t=1520994640085"}
)
