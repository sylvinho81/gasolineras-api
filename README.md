##### Description

REST API to search for gas stations in Spain.  

##### Prerequisites

The setups steps expect following tools installed on the system.

- Git
- Ruby [2.6.3]
- Rails [6.0.2]

##### 1. Check out the repository

```bash
git clone git@github.com:sylvinho81/gasolineras-api.git
```

##### 2. Configure database.yml file

Copy the sample database.yml file and edit the database configuration as required.

```bash
cp config/database.yml.sample config/database.yml
```


##### 3. Create and setup the database

Run the following commands to create and setup the database.

```ruby
bundle exec rake db:create
bundle exec rake db:setup
```

##### 4. Fetch data regarding gas stations in Spain 

```ruby
bundle exec rake gas_stations:fetch
```

##### 5. Start the Rails server

You can start the rails server using the command given below.

```ruby
bundle exec rails s
```

##### 6. Run tests

It is still in progress. Feel free to collaborate with pull requests.

```ruby
bin/rspec
```