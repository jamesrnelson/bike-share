# README
## Bike-Share

Bike-share is a web-app that utilizes bike share data, allowing users to see an overview and analytics of the rides, conditions, and stations in the  San-Francisco area. In order to gain full functionality of the site you will need to create and account and log in. The app includes an e-commerce shop for bike accessories. See the deployed version here: https://sleepy-taiga-28417.herokuapp.com/

### Setup

#### Ruby Version
* This app uses Ruby version 2.4.1 and up, and Rails 5.1.6

#### Creating the repository
* Clone this repository to your local machine from the command line
```
git clone git@github.com:anon0mys/bike-share.git
```
* Run bundle to install gem dependencies

#### Development Database Setup
* The database relies on sanitized data from the bike-share project. Find the raw data here: https://www.kaggle.com/benhamner/sf-bay-area-bike-share

* Download the csv data for the project and add it to the database directory in a subfolder named 'csv'. The path should be './db/csv/csv_files_go_here.csv'

* From the command line run:
```
ruby db/sanitizer.rb
```

* Create and seed the database:
```
rails db:{create,migrate,seed}
```
* There are no users in the seeds file. To create an admin user, use the rails console:
```ruby
User.create(name: 'any_name', username: 'your_username', password: 'your_password', status: 'admin')
```

#### Testing
* The test suite is written in rspec. Run the full suite with:
```
rspec
```

#### Deploying
* By default the sanitized data folder 'truncated_data' is ignored by git. In order to deploy, remove this line from .gitignore before deploying:
```
/db/truncated_data
```
