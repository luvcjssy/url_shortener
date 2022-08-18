### Prerequisites

The setup steps expect following tools installed on the system.

- Git
- Ruby 2.7.1
- Rails 6.0.4.7

#### 1. Check out the repository

- Clone repo

```bash
git clone git@github.com:luvcjssy/url_shortener.git
```

#### 2. Go to project directory

```bash
cd <path-to-project>
```

#### 3. Install gem

```bash
bundle install
```

#### 4. Create and migrate DB

```bash
bundle exec rake db:create
bundle exec rake db:migrate
```

#### 5. Start rails server

You can start the rails server using the command given below

```bash
bundle exec rails s
```

And now you can visit the site with the URL http://localhost:3000

### Run unit test

#### 1. Setup the database for testing

Run the following commands to create and setup the database

```bash
RAILS_ENV=test bundle exec rake db:create
RAILS_ENV=test bundle exec rake db:migrate
```

#### 2. Run rspec

- Open terminal and `cd <path-to-project>`
- Execute command to run rspec

```bash
bundle exec rspec spec
```
