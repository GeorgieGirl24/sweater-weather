<!-- Shields -->
![](https://img.shields.io/badge/Rails-5.2.4-informational?style=flat&logo=<LOGO_NAME>&logoColor=white&color=2bbc8a)
![](https://img.shields.io/badge/Ruby-2.5.3-orange)
![](https://img.shields.io/gem/v/fast_jsonapi)
![](https://img.shields.io/badge/GeorgieGirl24-Sweater--Weather-brightgreen)
![](https://img.shields.io/github/issues/GeorgieGirl24/sweater-weather)


# Sweater Weather

## Table of Contents
  - [What it does](#what-it-does)
  - [How to Install Sweater Weather](#how-to-install-sweater-weather)
  - [Endpoints](#endpoints)
  - [Schema](#schema)
  - [Dependencies](#dependencies)
  - [Testing](#testing)
  - [Learning Goals](#learning-goals)
  - [Licenses](#licenses)
  - [Contact](#contact)
  - [Acknowledgments](#acknowledgments)

## What it does

An API that drives the front-end Sweater Weather App. This application not only allows you plan a roadtrip to a city of your choosing, but also will get you up to date on the weather conditions of that city.

## How to Install Sweater Weather

For usage on your local machine follow the instructions listed below:

1. In your local environment:
```
git clone git@github.com:GeorgieGirl24/sweater-weather.git
cd 
bundle install
rake db:{create,migrate}
figaro install
```

2. Retrieve API keys:

* OpenWeatherMap  (Please use to [OpenWeather API documentation](https://openweathermap.org/api))
* MapQuest (Please use to [MapQuest API documentation](https://developer.mapquest.com/documentation/directions-api/route/get/))
* Unsplash (Please use to [Unsplash API documentation](https://unsplash.com/documentation))

3. Please make sure that after `application.yml` is created that you include the follwing keys:

```
WEATHER_API_KEY: <Your API Key>
IMAGE_API_KEY: <Your API Key>
MAP_API_KEY: <Your API Key>

WEATHER_API_HOST: 'http://api.openweathermap.org'
MAP_API_HOST: 'http://www.mapquestapi.com'
IMAGE_API_HOST: 'https://api.unsplash.com'
```
4. Open a new tab in the terminal and run:

`rails s`

5. In a web browser, navigate to `http://localhost:3000` to any of the `GET` routes in this repo

## Endpoints

* All Endpoints are formatted to JSON guidelines 

### 1. Retrieve weather for a City

This is an example of a successfull response in Postman:
* [Successful Forecast Response](https://i.imgur.com/bKVZXbr.png[/img])

```
GET /api/v1/forecast?location=denver,co
Content-Type: application/json
Accept: application/json
```

```
{
    "data": {
        "id": null,
        "type": "forecast",
        "attributes": {
            "current_weather": {
                "datetime": "2021-01-20T00:28:40.000-07:00",
                "sunrise": "2021-01-20T07:17:17.000-07:00",
                "sunset": "2021-01-20T17:05:57.000-07:00",
                "temperature": 26.55,
                "feels_like": 17.26,
                "humidity": 56,
                "uvi": 0,
                "visibility": 10000,
                "conditions": "clear sky",
                "icon": "01n"
            },
            "daily_weather": [
                {
                    "date": "2021-01-20",
                    "sunrise": "2021-01-20T07:17:17.000-07:00",
                    "sunset": "2021-01-20T17:05:57.000-07:00",
                    "max_temp": 47.53,
                    "min_temp": 26.55,
                    "conditions": "clear sky",
                    "icon": "01d"
                },
                {
                    "date": "2021-01-21",
                    "sunrise": "2021-01-21T07:16:42.000-07:00",
                    "sunset": "2021-01-21T17:07:06.000-07:00",
                    "max_temp": 43,
                    "min_temp": 34.09,
                    "conditions": "overcast clouds",
                    "icon": "04d"
                },...
                
            ],
            "hourly_weather": [
                {
                    "time": "00:00:00",
                    "temperature": 26.55,
                    "wind_speed": "6.6 mph",
                    "wind_direction": "from WSW",
                    "conditions": "clear sky",
                    "icon": "01n"
                },...  
            ]
        }
    }
}
```


### 2. Background Image of the City

This is an example of a successfull response in Postman:
* [Successful Background Response](https://i.imgur.com/4haxZs3.png[/img])


```
GET /api/v1/backgrounds?location=denver,co
Content-Type: application/json
Accept: application/json
```

```
{
    "data": {
        "id": null,
        "type": "image",
        "attributes": {
            "image": {
                "image_url": "https://images.unsplash.com/photo-1519424187720-db6d0fc5a5d2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MXwxOTkxNTl8MHwxfHNlYXJjaHwxfHwlN0IlMjJsb2NhdGlvbiUyMj0lM0UlMjJkZW52ZXIsY28lMjIlN0R8ZW58MHx8fA&ixlib=rb-1.2.1&q=80&w=1080",
                "link": "https://unsplash.com/photos/chaqHXlOzYs"
            },
            "credit": {
                "source": "https://unsplash.com/",
                "artist": "Owen Lystrup",
                "artist_link": "https://unsplash.com/@owencavlys"
            }
        }
    }
}
```


### 3. User Registration

This is an example of a successfull response in Postman:
* [Successful Registration Response](https://i.imgur.com/pSQjiNg.png[/img])


```
POST /api/v1/users
Content-Type: application/json
Accept: application/json
```

```
JSON request body

{
  "email": "whatever7@example.com",
  "password": "password",
  "password_confirmation": "password"
}
```

```
{
    "data": {
        "id": "6",
        "type": "users",
        "attributes": {
            "email": "whatever7@example.com",
            "api_key": "3uqJRZzgHKutjOmYBiKWLwtt"
        }
    }
}
```


Some links to check out for unsuccessful responses:
* [User Error: Email already exsists](https://i.imgur.com/PsWvwm9.png[/img])
* [User Error: Email already exsists](https://i.imgur.com/PsWvwm9.png[/img])
* [User Error: Passwords Dont Match](https://i.imgur.com/1r8WERC.png[/img])
* [User Error: Email is left blank](https://i.imgur.com/3LVCkFv.png[/img])


### 4. Login

This is an example of a successfull response in Postman:
* [Successful Login Response](https://i.imgur.com/lyeL3Sp.png[/img])


```
POST /api/v1/sessions
Content-Type: application/json
Accept: application/json
```

```
JSON request body

{
  "email": "whatever@example.com",
  "password": "password"
}
```

```
{
    "data": {
        "id": "2",
        "type": "users",
        "attributes": {
            "email": "whatever@example.com",
            "api_key": "slDxY2LlnLsKTI85VJdJ4Att"
        }
    }
}
```

Some links to check out for unsuccessful responses:
* [Sessions Error: Bad creditials](https://i.imgur.com/p2THrjS.png[/img])

### 5. Roadtrip 

This is an example of a successfull response in Postman:
* [Successful Roadtrip Response](https://i.imgur.com/btPSuKW.png[/img])


```
POST /api/v1/road_trip
Content-Type: application/json
Accept: application/json
```

```
JSON request body

{
  "origin": "Denver,CO",
  "destination": "Pueblo,CO",
  "api_key": "GTWzPl3kxUSBxaCRqiCTOQtt"
}
```


```
{
    "data": {
        "id": null,
        "type": "roadtrip",
        "attributes": {
            "start_city": "Denver,CO",
            "end_city": "Pueblo,CO",
            "travel_time": "01:44:22",
            "weather_at_eta": {
                "temperature": 36.95,
                "conditions": "light rain"
            }
        }
    }
}
```

Some links to checkout other responses:
* [Really Long Roadtrip](https://i.imgur.com/xfLR3Rz.png[/img])
* [Roadtrip Error: Impossible route](https://i.imgur.com/4haxZs3.png[/img])


## Schema

* Users is the only table in the database. It hold an email, password_digest, and api key 

## Dependencies

 * figaro
 * faraday
 * fast_jsonapi
 * webmock
 * vcr
 * shoulda-matchers
 * simplecov

## Testing

* Fully tested with RSpec

* RSpec is a tool for unit testing that will ensure there is the intended functionality at each level of our code.

* In order to run the tests, run `bundle exec rspec` in the command line and you should have all passing tests.

## Learning Goals

  * Expose an API that aggregates data from multiple external APIs
  
  * Expose an API that requires an authentication token
  
  * Expose an API for CRUD functionality
  
  * Determine completion criteria based on the needs of other developers
  
  * Research, select, and consume an API based on your needs as a developer
  
## Licenses

  * Ruby 2.5.3
  * Rails 2.5.4.3

## Contact

#### [George Soderholm](https://github.com/GeorgieGirl24): [![LinkedIn][linkedin-shield]](https://www.linkedin.com/in/george-soderholm-05776947/), [Email](mailto:georgesoderholm@gmail.com)

## Acknowledgments

Thank you to Ian Douglas and Dione Wilson for being such amazing instructors and guiding me through this project!

<!-- MARKDOWN LINKS -->
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=flat-square&logo=linkedin&colorB=555
