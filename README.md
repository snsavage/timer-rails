# Timer Rails

Timer Rails provides the API for my Timer React project.  Timer Rails is currently a work in progress.

Timer Rails was created as a project for the [ Flatiron School's Online Web
Developer Program ](https://flatironschool.com/programs/online-web-developer-career-course).

## Setup

Local development for Rails Timer can be setup with the following steps. Please submit a bug report if these steps don't work for you.

You will need the following software:

* Git
* Ruby v2.3.1
* PostgreSQL

After cloning this GitHub repo, don't forget to bundle install and run the
database migrations.

```bash
$ git clone https://github.com/snsavage/timer-rails.git
$ bundle install
$ rake db:create
$ rake db:migrate
$ rake db:migrate RAILS_ENV=test
$ rails server
```

Seed data is available by running `rake db:seed`.

## Testing

Timer Rails has a test suite built with rspec. The test suite can be run with
the commands:

```bash
$ rspec              # OR
$ bundle exec rspec  # Depending on your system configuration.
```

## Contributing

Bug reports and pull requests are welcome on GitHub at
[https://github.com/snsavage/timer-rails/issues](https://github.com/snsavage/timer-rails/issues).
Please read the [Contributing Guide](./CONTRIBUTING.md).  This project is
intended to be a safe, welcoming space for collaboration, and contributors are
expected to adhere to the [Code of Conduct](./CODE_OF_CONDUCT.md).
Questions?

## Questions?

Please contact [snsavage@snsavage.com](mailto:snsavage@snsavage.com).

## License

Rails Timer is released on the [MIT License](./LICENSE).
