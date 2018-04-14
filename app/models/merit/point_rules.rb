# Be sure to restart your server when you modify this file.
#
# Points are a simple integer value which are given to "meritable" resources
# according to rules in +app/models/merit/point_rules.rb+. They are given on
# actions-triggered, either to the action user or to the method (or array of
# methods) defined in the +:to+ option.
#
# 'score' method may accept a block which evaluates to boolean
# (recieves the object as parameter)

module Merit
  class PointRules
    include Merit::PointRulesMethods

    def initialize
      # score 10, :on => 'users#create' do |user|
      #   user.bio.present?
      # end
      #
      # score 15, :on => 'reviews#create', :to => [:reviewer, :reviewed]
      #
      # score 20, :on => [
      #   'comments#create',
      #   'photos#create'
      # ]
      #
      # score -10, :on => 'comments#destroy'
      #score 5, on: 'trip_gostations#check', category: 'trip_gostations'

      #score 100, on: 'trip_gostations#check', category: 'trip_gostations' do |trip_gostation|
      #  Challenge.find_by(trip_id: 1, user_id: (trip_gostation.user_id)).present?
      #end
      #score 5, on: 'gostations#checkin', category: 'gostations'

    end
  end
end
