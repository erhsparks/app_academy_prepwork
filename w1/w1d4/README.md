# W1D4: In Words

**Note:** Please review the [pairing setup][pairing-setup] guide if you
need a refresher on setting up your pairing session.

[pairing-setup]: ../../pairing-setup.md

### Automated Testing

Today's material comes from a Ruby tutorial called [Test-First
Ruby][test-first-ruby]. The problem comes with a set of automated tests,
which have been written using RSpec, one of the most popular automated
testing frameworks in Ruby. Incidentally, it's also the testing
framework we use to write assessments at App Academy (so consider this
your first taste of assessment prep!) These automated tests will serve
as guidelines for the desired functionality of our program. If we run
the tests regularly, they will also serve as a measure of our progress
through the project.

[test-first-ruby]: https://github.com/appacademy/test-first-ruby

### Getting Started

Download the [zip][w1d4-zip] containing the day's exercises. Extract it
to a directory on your computer and upload the folder to your Cloud9
workspace (you can do this by selecting **File > Upload Files** from the
Cloud9 menu toolbar). Navigate to the directory in your terminal. There
you'll find a few things:

- a `Gemfile`: this specifies the gem versions we'll be using in our
  project. We can manage gem versions with the `bundler` gem (more
  on that soon).
- a `spec` folder: this is where the tests are written. You should read
  these before writing any code. Don't be intimidated! The syntax is
  pretty easy to follow.
- a `lib` folder: this is where you'll be writing your code.

[w1d4-zip]: ./w1d4.zip

Your first order of business should be to run `gem install bundler`,
followed by `bundle install`. The first command installs the `bundler`
gem; the second uses `bundler` to install the gems required by our
project (these are specified in the `Gemfile`). Now we can run the
following command:

```sh
bundle exec rspec spec/15_in_words_spec.rb
```

Let's dissect this. `bundle exec` is a prefix; it runs a command,
forcing it to use the gem versions from our `Gemfile`. `rspec` is the
command to run our tests, or _specifications_. Finally, we provide
`rspec` with an argument: the path to the file containing our tests.

### Red, Green, Refactor

In order to develop our code in a _test-driven_ way, we're going to let
the tests guide our implementations. Run the tests early and often,
using the command above. The test output should be red (failing) at
first. Try to figure out why, and make the necessary corrections. Once
you've implemented the required classes and methods (and they behave as
expected), the test output will be green (passing). Once you hit this
point, it's time to go back and refactor. We're not concerned that your
solutions are optimal with respect to runtime and memory use; we would
much rather see you revise your code for clarity and modularity
(remember to keep your code DRY--Don't Repeat Yourself)!

### Other Tips

- Read the comments in `spec/15_in_words_spec.rb`; (in fact, you should
  always read the `spec` files thoroughly), and heed their wisdom.
- Reading error messages is a skill that will be **crucial** to your
  success as a developer. The better you get at reading error messages,
  the easier it will be to figure out why your code isn't working (and
  what you can do to fix it).

### Project Overview

Today we'll be monkey-patching the Fixnum class to add an #in_words
method. This method will return an English-language representation of
the integer it is called on. You'll find more information in the
`spec/15_in_words_spec.rb` file.
