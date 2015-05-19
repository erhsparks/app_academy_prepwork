# Test-First Ruby (Part I)

Welcome to Test-First Ruby! Today's material is designed to help you
review what you've learned over the last week. It's also intended to
familiarize you with RSpec, one of the most popular automated testing
frameworks in Ruby. Incidentally, it's also the testing framework we use
to write assessments at App Academy (so consider this your first taste
of assessment prep!)

## Getting Started

Download the [zip][w1d5-zip] containing the day's exercises. Extract it
to a location on your computer and navigate to that directory in your
terminal (for example, `cd ~/Downloads/w1d5`). You'll find a few things
in the directory:

- a `Gemfile`: this specifies the gem versions we'll be using in our
  project. We can manage gem versions with the `bundler` gem (more
  on that soon).
- a `spec` folder: this is where the tests are written. You should read
  these before writing any code. Don't be intimidated! The syntax is
  pretty easy to follow.
- a `lib` folder: this is where you'll be writing your code.

[w1d5-zip]: ./w1d5.zip

Your first order of business should be to run `gem install bundler`,
followed by `bundle install`. The first command installs the `bundler`
gem; the second installs the gems required by our project in the
`Gemfile`. Now we can run the following command:

```sh
bundle exec rspec spec/00_hello_spec.rb
```

Let's dissect this. `bundle exec` is a prefix; it runs a command,
forcing it to use the gem versions from our `Gemfile`. `rspec` is the
command to run our tests, or _specifications_. Finally, we provide
`rspec` with an argument: the path to the file containing our tests.

## Red, Green, Refactor

In order to develop our code in a _test-driven_ way, we're going to let
the tests guide our implementations. Run the tests early and often,
using the command above. The test output should be red (failing) at
first. Try to figure out why, and make the necessary corrections. Once
you've implemented the required classes and methods (and they behave as
expected), the test output will be green (passing). Once you hit this
point, it's time to go back and refactor. We're not concerned that your
solutions are optimal with respect to runtime and memory use; we would
much rather see you revise your code for clarity and readability.

## Other Tips

- Read the comments in `spec/00_hello_spec.rb`; (in fact, read all of
  the `spec` files thoroughly), and heed their wisdom.
- Reading error messages is a skill that will be **crucial** to your
  success as a developer. The better you get at reading error messages,
  the easier it will be to figure out why your code isn't working (and
  what you can do to fix it).
