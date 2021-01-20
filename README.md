<!-- Shields -->
![](https://img.shields.io/badge/Rails-5.2.4-informational?style=flat&logo=<LOGO_NAME>&logoColor=white&color=2bbc8a)
![](https://img.shields.io/badge/Ruby-2.5.3-orange)
![](https://img.shields.io/gem/v/fast_jsonapi)
![](https://img.shields.io/badge/GeorgieGirl24-Sweater--Weather-brightgreen)
![](https://github.com/GeorgieGirl24/sweater-weather/stargazers)
![](https://img.shields.io/github/issues/GeorgieGirl24/sweater-weather)
![](https://shields.io/endpoint)

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


To view the other components of the application please visit the [Github Project Organization](https://github.com/sweater-weather).

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
2. Please make sure that after `application.yml` is created that you include the follwing keys:

```
WEATHER_API_KEY: <Your API Key>
IMAGE_API_KEY: <Your API Key>
MAP_API_KEY: <Your API Key>
YELP_API_KEY: <Your API Key>

WEATHER_API_HOST: 'http://api.openweathermap.org'
MAP_API_HOST: 'http://www.mapquestapi.com'
IMAGE_API_HOST: 'https://api.unsplash.com'
```
3. Open a new tab in the terminal and run:

`rails s`

4. In a web browser, navigate to `http://localhost:3000` to any of the `GET` routes in this repo

## Endpoints

1. Retrieve weather for a City

```
GET /api/v1/forecast?location=denver,co
Content-Type: application/json
Accept: application/json
```

This is an example of what a successful response:

<a href="https://imgur.com/bKVZXbr"><img src="https://i.imgur.com/bKVZXbr.png" title="successful forecast example" /></a>


2. Background Image of the City

```
GET /api/v1/backgrounds?location=denver,co
Content-Type: application/json
Accept: application/json
```

This is an example of a successfull response:

<a href="https://imgur.com/4haxZs3"><img src="https://i.imgur.com/4haxZs3.png" title="source: imgur.com" /></a>

3. User Registration

```
POST /api/v1/users
Content-Type: application/json
Accept: application/json
```
This is an example of a successfull response:

<a href="https://imgur.com/pSQjiNg"><img src="https://i.imgur.com/pSQjiNg.png" title="successful user example" /></a>

4. Login

```
POST /api/v1/sessions
Content-Type: application/json
Accept: application/json
```
This is an example of a successfull response:

<a href="https://imgur.com/lyeL3Sp"><img src="https://i.imgur.com/lyeL3Sp.png" title="successful sessions example" /></a>

5. Roadtrip 

```
POST /api/v1/road_trip
Content-Type: application/json
Accept: application/json
```
This is an example of a successfull response:

<a href="https://imgur.com/btPSuKW"><img src="https://i.imgur.com/btPSuKW.png" title="successful roadtrip example" /></a>






<a href="https://imgur.com/lyeL3Sp"><img src="https://i.imgur.com/lyeL3Sp.png" title="successful sessions example" /></a>





<a href="https://imgur.com/PsWvwm9"><img src="https://i.imgur.com/PsWvwm9.png" title="ERROR exisisting email for user example " /></a>


<a href="https://imgur.com/1r8WERC"><img src="https://i.imgur.com/1r8WERC.png" title="ERROR passwords dont match for user example" /></a>


<a href="https://imgur.com/3LVCkFv"><img src="https://i.imgur.com/3LVCkFv.png" title="ERROR email is left blank" /></a>


<a href="https://imgur.com/p2THrjS"><img src="https://i.imgur.com/p2THrjS.png" title="ERROR bad creditials for sessions example" /></a>


<a href="https://imgur.com/xfLR3Rz"><img src="https://i.imgur.com/xfLR3Rz.png" title="Long roadtrip example" /></a>


[Really Long Roadtri](https://i.imgur.com/xfLR3Rz.png[/img])

[Roadtrip Error: Impossible route](https://i.imgur.com/4haxZs3.png[/img])
## Schema


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
