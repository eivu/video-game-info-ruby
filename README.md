# EivuVideoGameInfo

ruby client for parsing data sourced from [https://www.launchbox-app.com/](https://www.launchbox-app.com/)

Only Supporting Cartridges for Rom format matching, Disc based system are all .bin, .cue, and .iso.
Not only impossible to distinguish but is not supported on the browser rom emulator

Dependendicies
sqlite
unar - https://theunarchiver.com/

## Installation

TODO: Replace You can install it as a gem:

```
gem install eivu_video_game_info
```

or add it into a Gemfile (Bundler):

```ruby
gem 'eivu_video_game_info'
```

## Usage

```ruby
path_to_rom = "spec/fixtures/roms/gba/butano-fighter.gba"
EivuVideoGameInfo::Loader.setup # placed for historical purposes only
# create a list of all matched and unmatched roms in folder & subfolders
EivuVideoGameInfo::Utils.inspect_library(path_to_roms)
# extract all archives in folder & subfolders
EivuVideoGameInfo::Utils.extract_all(path_to_roms)
# retrieve info for a rom
EivuVideoGameInfo::Models::Game.fetch_rom_info(path_to_rom)
# retrieve info for a rom, in json format
EivuVideoGameInfo::Models::Game.fetch_rom_info_as_json(path_to_rom_file)
# (used internally) create unique slug from rom filename
EivuVideoGameInfo::Models::Game.slugify_rom(path_to_rom_file)
# (used internally) create unique slug from  string
EivuVideoGameInfo::Models::Game.slugify_string(path_to_rom_file)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/eivu/eivu_video_game_info. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/eivu/video-game-info-ruby/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the EivuVideoGameInfo project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/eivu/blob/main/CODE_OF_CONDUCT.md).
