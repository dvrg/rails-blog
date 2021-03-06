# Ruby on Rails Tutorial sample application

Link demo application [Link](https://obscure-inlet-17617.herokuapp.com/).

## License

All source code in the [Ruby on Rails Tutorial](https://www.railstutorial.org/)
is available jointly under the MIT License and the Beerware License. See
[LICENSE.md](LICENSE.md) for details.

## Getting started

To get started with the app, clone the repo and then install the needed gems:

```
$ bundle install --without production
```

Create the database

```
$ rake db:create
```

Next, migrate the database:

```
$ rake db:migrate
```

Seed data

```
$ rake db:seed
```

Finally, run the test suite to verify that everything is working correctly:

```
$ rails test
```

If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
```

Jalanin sesuai environment production

```
$ rails server --environment production
```

Migrate sesuai environtment

```
$ rails db:migrate RAILS_ENV=production
```

For more information, see the
[_Ruby on Rails Tutorial_ book](https://www.railstutorial.org/book).
