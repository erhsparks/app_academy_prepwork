# How to Run RSpec Tests

When you download each day's exercises, you'll find that they come
packaged in a particular folder structure. In your file system, it
should look something like this:

```
w1d1/
 |- lib/
 |- spec/
 |- Gemfile
 |- Gemfile.lock
```

The files are structured in this way to make it easy to run the
automated test suite for the day's work. Before we run the tests, we'll
have to make sure we have the right gems installed.

```sh
~$ cd w1d1
~$ gem install bundler
~$ bundle install
```

Here's what's happening:
1. `cd w1d1` will navigate us to the exercises directory.

2. `gem install bundler` will do what it says: install the Bundler gem.
   Bundler is useful for managing the development environment for a
   project; essentially, it "locks" you into using a particular version
   of each gem in the Gemfile. This makes it easy for someone to
   download our project and get exactly the same results when running
   it.

3. `bundle install` will download and install the gems from the Gemfile.
   After this step, we're ready to run the tests locally.

After you've gone through this setup process, you're ready to run the
specs. Here are a couple ways to do so:

To run all the specs for a day:

```sh
~$ bundle exec rspec
```

To run just one spec file, you can pass an [optional] filename argument:

```sh
~$ bundle exec rspec spec/00_hello_spec.rb
```

To run a single test (or a set of tests), you can append the line number
to the filename argument:

```sh
~$ bundle exec rspec spec/00_hello_spec.rb:7
```

And that's all there is to it. Armed with this knowledge, go forth and
complete the exercises!
