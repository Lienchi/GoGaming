# README

Gogaming

This is a gamification web application for Gogoro, a Smartscooter  company, aiming to improve below:

1. user experience and participation.
2. utilization ratio of Smartscooter and Smart Energy

In this application, users are able to :
1. get directions , nearby Gostations and Gogoro friendly store.
2. Checkin gostation
3. challenge on a Trip
4. win Points , Badges, and upgrade Leaderboard. (PBL)
5. Follow another user
6. leave a Comment on a Trip

Screenshots (attached below pages)       

1. gostations#index
2. trips#index
3. trips#show
4. users#show

Getting Started

Run bundle install
Run rails db:migrate


Prerequisites

Please check on Merit to understand the PBL structure.

ERD  (attached ERD here)
*note
Challenge :  a trip which user completed
Trip_gostation: a gostation "belongs to a trip" 
Checkin: a gostation which user checkin to ("not belongs to a trip")


How to win badges
 A trip include many trip_gostations , if all the trip_gostations#check status is true. Trip is completed (Challenge then create to user) and Badge will issue by Merit

How to win points

(1) receive a badge
(2) gostations#checkin status is true

Built With
Rails '~> 5.1.5' - frame work
Google Map API 
Gon Gem
Merit Gem - PBL system
Bootstrap3 - Front End

Deployment

Heroku
Amazon S3


Authors
Lienchi  
Sapphirekuo 
anna770822
