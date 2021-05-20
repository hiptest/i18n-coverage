# I18n-coverage
[![Build Status](https://travis-ci.org/hiptest/i18n-coverage.svg?branch=master)](https://travis-ci.org/hiptest/i18n-coverage)
[![Maintainability](https://api.codeclimate.com/v1/badges/30a359b5ad82800c5d35/maintainability)](https://codeclimate.com/github/hiptest/i18n-coverage/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/30a359b5ad82800c5d35/test_coverage)](https://codeclimate.com/github/hiptest/i18n-coverage/test_coverage)

Simple gem to see how much of your i18n keys are used during tests. It requires that the translations are handled by the [i18n](https://rubygems.org/gems/i18n/) gem.

This gem is not meant to replace tools such as [i18n-tasks](https://rubygems.org/gems/i18n-tasks), but more to give you an idea of which keys are not covered by tests (especially when adding translations to a gem where strings were hard-coded previously).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'i18n-coverage'
```

## Usage

Add the following lines somewhere to your test setup. For RSpec, this will be at the top of `spec_helper.rb`.

```ruby
require 'i18n/coverage'
I18n::Coverage.start
```

If you don't want to check I18n Coverage in every test run, you could enable it with an environment variable.

```ruby
# file spec_helper.rb
require 'i18n/coverage'
I18n::Coverage.start if ENV['I18N_COVERAGE']
```

```shell
I18N_COVERAGE=1 bundle exec rspec
```

## Configuration

The default config is [here](lib/i18n/coverage/config.rb).

### Printer

By default the coverage is output to the console. You can also select a different printer, or write your own!

```ruby
require 'i18n/coverage'
require 'i18n/coverage/printers/file_printer'
I18n::Coverage.config.printer = I18n::Coverage::Printers::FilePrinter
I18n::Coverage.start
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests, or just `rake` to run all tasks, such as linting. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hiptest/i18n-coverage.
