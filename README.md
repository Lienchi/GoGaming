# GoGaming

## This is a gamification web application for Gogoro, a Smartscooter  company, aiming at below:

* Improve the way of searching Gostations.
* Makes Riding Gogoro to be fun!

## In this application, users are able to :

* Plan their routes, directions and find Gostations or Friendly Store nearby
* Challenge on a Trip and get badge, points if trip is completed
* Be rewarded by badges, points , ranking and Gogoro products.




# Screenshot

<img src="https://github.com/Lienchi/GoGaming/blob/master/app/assets/images/screenshot/root.png" width="30%">


# Getting Started

1. Run `bundle install`
2. Run `rails db:migrate`
3. Run `rails db:seed`


# Prerequisites

Please check on [Merit](https://github.com/merit-gem/merit) to understand the PBL structure.

# ERD

![image](https://github.com/Lienchi/GoGaming/blob/master/app/assets/images/screenshot/ERD.png)


- **Challenge:**  a trip which user completed
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

# Custom Config setting

Please set you own configurations for both development and production

- config/locales/email
- config/locales/facebook.yml
- config/initializers/carrierwave.rb

# Authors
- [Lienchi](https://github.com/Lienchi)  
- [Sapphirekuo](https://github.com/sapphirekuo)
- [anna770822](https://github.com/anna770822)

# In Progress
- Stablize Google Map Function (done)
- RSpec
- Adjust UI
- Add picture to site modal (done)
- Add trips#show site list to modal (done)
- Detect user current location when checkin (or every few hours?)
- Limit Checkin count to "8" per month
- Attach gogaming.solutions to heroku sites (done)

