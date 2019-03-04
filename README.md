# Luned

Inspired by tales of the moon and weather's affect on Emergency services, Luned pulls Seattle's public 911 data and combines with hourly weather and lunar phase data.

## Installation
Install:

    $ gem install Luned

The two APIs this project uses require tokens.

Register for a Dark Sky token here: https://darksky.net/dev/register
And a Socrata token here: https://opendata.socrata.com/login

Create a .env file in the project's root folder with the following expressions:

  * socrata=<your_socrata_token>
  * dar_sky=<your_dark_sky_token>

## Usage

Takes combinations of number representations of year, month, day and hour. Full phrases aren't required. All time are Seattle local Pacific time. Examples:

  * 2018 2 3 16 <enter> would displays data for 03 Feb 2018 4:00pm Pacific
  * 2019 1 4 <enter> displays 04 Jan 2019 Pacific
  * 2017 8 <enter> displays August 2017 Pacific

  <..> Move up a level
  <q> Quit
  <enter> Re-display current level.  Help at the day level after displaying multiple hours.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/davisjustinw/luned. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Luned project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/davisjustinw/luned/blob/master/CODE_OF_CONDUCT.md).

## Attribution

Powered by Dark Sky: https://darksky.net/poweredby
Powered by Socrata: https://dev.socrata.com/
