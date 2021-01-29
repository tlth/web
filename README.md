## :warning: Decomissioned & archived 2021-01-29 in favour of squarespace hosted website :warning:


# Teknologkåren LTH


This is the repository containing the code for the Rails application acting as a CMS system for Teknologkåren at LTH

## Development setup

### Pre-setup

0. Use a Linux/OSX environment, if developing on Windows use vagrant and follow the instructions below to easily set up a vm.
0. Install the development requirements
  0. PostgreSQL as Database manager
  0. ImageMagick
  0. NodeJS, Rails uses a execjs runtime to precompile assets
  0. Ruby
    - It is good to use an environment manager to handle different versions,
    - [`rbenv`](https://github.com/rbenv/rbenv) works good,
    - [`ruby build`](https://github.com/rbenv/ruby-build) allows installing of different ruby versions.

### Setup

- run `bin/setup` to download and install gems, setup database and add some development data,
- run `rails s` to start the server,
- `rails c` gives access to the rails console.

## Notes

Most configuration is stored in either `config/application.rb` or `config/enviroments/production.rb`
Configuration for the mailer is located in `config/enviroments/production.rb`
Credentials are stored in environment variables and accessed in the `secrets.yml` file

The site is currently hosted on Heroku, and is started using the Procfile.
CoffeeScript is used for some behavior instead of JavaScript, and SCSS is used to make CSS more organized and efficient.

### Vagrant (for Windows)

```
#!sh
  vagrant up
  vagrant ssh
  cd /vagrant
  bin/bundle install --without production
  bin/rake db:create db:migrate
  TRUSTED_IP=`netstat -rn | grep "^0.0.0.0 " | cut -d " " -f10` bin/rails s
```

The reasons for using rails s with **TRUSTED_IP** is to make sure better_errors is working as it should on the Vagrant machine.
If better_errors doesn't work try using: **TRUSTED_IP=0.0.0.0/0 rails s**
