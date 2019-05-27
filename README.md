# I18n-coverage
[![Build Status](https://travis-ci.org/hiptest/i18n-coverage.svg?branch=master)](https://travis-ci.org/hiptest/i18n-coverage)

Simple gem to see how much of your i18n keys are used during tests. It requires that the translations are handled by the [i18n](https://rubygems.org/gems/i18n/) gem.

This gem is not meant to replace tools such as [i18n-tasks](https://rubygems.org/gems/i18n-tasks), but more to give you an idea of which keys are not covered by tests (especially when adding translations to a gem where strings were hard-coded previously).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'i18n-coverage'
```

## Usage

First, you need to ensure that the gem is correctly loaded when running the tests. When using rspec for example:

```ruby
# file spec_helper.rb
require 'i18n-coverage'
```

You also need to output/read the results of the coverage. This should be done once all the tests have been executed. Once again, an example with rspec:

```ruby
RSpec.configure do |config|
  config.after(:suite) do
    I18n::Coverage::Reporter.report if ENV['I18N_COVERAGE']
  end
end
```

Then, when running the tests, you need to enable coverage by setting the environment variable `I18N_COVERAGE`. For example with rspec:

```shell
I18N_COVERAGE=1 bundle exec rspec
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hiptest/i18n-coverage.
