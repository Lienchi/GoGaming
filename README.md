# GoGaming

## This is a gamification web application for Gogoro, a Smartscooter  company, aiming to improve below:

* user experience and participation.
* utilization ratio of Smartscooter and Smart Energy

## In this application, users are able to :

* get directions , nearby Gostations and Gogoro friendly store.
* Checkin gostation
* challenge on a Trip
* win Points , Badges, and upgrade on Leaderboard. (PBL)
* Follow another user
* leave a Comment on a Trip



# Screenshot

![image](https://github.com/Lienchi/GoGaming/blob/master/app/assets/images/screenshot/index.png)
![image](https://github.com/Lienchi/GoGaming/blob/master/app/assets/images/screenshot/trip_index.png)
![image](https://github.com/Lienchi/GoGaming/blob/master/app/assets/images/screenshot/trip_show.png)
![image](https://github.com/Lienchi/GoGaming/blob/master/app/assets/images/screenshot/user_show.png)

# Getting Started

1. Run `bundle install`
2. Run `rails db:migrate`
3. Run `rails db:seed`


# Prerequisites

Please check on [Merit](https://github.com/merit-gem/merit) to understand the PBL structure.

# ERD

![image](https://github.com/Lienchi/GoGaming/blob/master/app/assets/images/screenshot/ERD.png)


- **Challenge:**  a trip which user completed
- **Trip_gostation:** a gostation "belongs to a trip" 
- **Checkin:** a gostation which user checkin to ("not belongs to a trip")



# How to win badges

A trip include many trip_gostations , if all the trip_gostations#check status is true. Trip is completed (Challenge then create to user) and Badge will issue by Merit

# How to win points

1. receive a badge
2. gostations#checkin status is true

# Built With

- Rails '~> 5.1.5' - frame work
- Google Map API 
- [gon](https://github.com/gazay/gon)
- [Merit](https://github.com/merit-gem/merit) PBL system
- Bootstrap3 - Front End

# Deployment

- Heroku
- Amazon S3


# Authors
- Lienchi  
- Sapphirekuo 
- anna770822

