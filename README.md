# Koroibos (Mod 4 Take Home Challenge)

## Introduction

This repo is meant to emulate a submission for a take home challenge that might be issued by a company to an applicant. The spec for the challenge can be found [here](https://github.com/turingschool/backend-curriculum-site/blob/gh-pages/module4/projects/take_home_challenge/prompts/olympic_spec.md). In short, a csv file was provided with mock olympic data that needed to be exposed via API endpoints (seen below). Though it is functional and readily available via Heroku, it is not intended for public use.

## Tech Stack

- Rails (5.2.4.1)
- Ruby (2.4.1)
- PostgreSQL (11.5)

## Getting Started

### Install Necessary Dependencies

Rails requires Ruby to be installed. For more information on installing Ruby, please see [here](https://www.ruby-lang.org/en/documentation/installation/).

Once Ruby has been installed, Rails can be installed using `gem install Rails`. For more information on installing Rails, please see [here](https://guides.rubyonrails.org/v5.0/getting_started.html).

This repo uses a PostgreSQL database. Rails mostly handles database management, however PostgreSQL will need to be installed prior. For more information about installing PostgreSQL, please see [here](https://www.postgresql.org/download/).

Once Ruby, Rails, and PostgreSQL have been installed, run `bundle install` from the project directory to install all necessary dependencies.

### Create and Migrate Database

To create and migrate the database, run the following commands:

```
rails db:create
rails db:migrate
```

### Importing Data

A custom rake task has been created for importing the olympic CSV data. All data is stored in the `olympians.csv` file in the root directory. The rake task is called `import_olympic_data` and can be found in `/lib/tasks/import_olympic_data.rake`. All existing rake tasks can be seen using `rake -T`. To run the task, use `rake import_olympic_data`. The database will need to be created and migrated prior to running the rake task.

### Running a Local Server

To run a local instance of the Rails server, user `rails s`.

### Testing

Testing is done using RSpec. All tests are located in the `/spec` folder. To run tests, use the `rspec` command. SimpleCov has also been included to monitor test coverage. Every time `rspec` is run, SimpleCov updates its coverage. To see coverage, use `open coverage/index.html` from the root directory. This will open a webpage with a coverage breakdown by percentage.

## Endpoints

### Olympians

#### Get All Olympians:

Request:
```
GET /api/v1/olympians
```
Sample Response:
```
{
  "olympians":
    [
      {
        "name": "Maha Abdalsalam",
        "team": "Egypt",
        "age": 18,
        "sport": "Diving"
        "total_medals_won": 0
      },
      {
        "name": "Ahmad Abughaush",
        "team": "Jordan",
        "age": 20,
        "sport": "Taekwondo"
        "total_medals_won": 1
      },
      {...}
    ]
}
```

#### Get Youngest Olympian:

Request:
```
GET /api/v1/olympians?age=youngest
```
Sample Response:
```
{
  "olympians":
    [
      {
        "name": "Ana Iulia Dascl",
        "team": "Romania",
        "age": 13,
        "sport": "Swimming"
        "total_medals_won": 0
      }
    ]
}
```

#### Get Oldest Olympian:

Request:
```
GET /api/v1/olympians?age=oldest
```
Sample Response:
```
{
  "olympians":
    [
      {
        "name": "Julie Brougham",
        "team": "New Zealand",
        "age": 62,
        "sport": "Equestrianism"
        "total_medals_won": 0
      }
    ]
}
```

### Olympian Stats

#### Get Olympian Stats:

Request:
```
GET /api/v1/olympian_stats
```
Sample Response:
```
{
  "olympian_stats": {
    "total_competing_olympians": 3120
    "average_weight:" {
      "unit": "kg",
      "male_olympians": 75.4,
      "female_olympians": 70.2
    }
    "average_age:" 26.2
  }
}
```

### Events

#### Get All Events:

Request:
```
GET /api/v1/events
```
Sample Response:
```
{
  "events":
    [
      {
        "sport": "Archery",
        "events": [
          "Archery Men's Individual",
          "Archery Men's Team",
          "Archery Women's Individual",
          "Archery Women's Team"
        ]
      },
      {
        "sport": "Badminton",
        "events": [
          "Badminton Men's Doubles",
          "Badminton Men's Singles",
          "Badminton Women's Doubles",
          "Badminton Women's Singles",
          "Badminton Mixed Doubles"
        ]
      },
      {...}
    ]
}
```

#### Get Medalists for an Event:

Request:
```
GET /api/v1/events/:id/medalists
```
Sample Response:
```
{
  "event": "Badminton Mixed Doubles",
  "medalists": [
      {
        "name": "Tontowi Ahmad",
        "team": "Indonesia-1",
        "age": 29,
        "medal": "Gold"
      },
      {
        "name": "Chan Peng Soon",
        "team": "Malaysia",
        "age": 28,
        "medal": "Silver"
      }
    ]
}
```

### Database Schema
![]()

## Project Board

[GitHub Project Board](https://github.com/grwthomps/mod4_take_home_challenge_koroibos/projects/1)

## Core Contributors

[Graham Thompson](https://github.com/grwthomps)
