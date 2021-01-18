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
  - [API Contract](#api-contract)
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

```
git clone git@github.com:GeorgieGirl24/sweater-weather.git
cd 
bundle install
rake db:{create,migrate}
figaro install
rails s
get calls to: localhost:3000 in your web browser
```

## API Contract


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
