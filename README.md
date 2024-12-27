ruby client for parsing data sourced from [https://www.launchbox-app.com/](https://www.launchbox-app.com/)

Only Supporting Cartridges for Rom format matching, Disc based system are all .bin, .cue, and .iso.
Not only impossible to distinguish but is not supported on the browser rom emulator

Dependendicies
sqlite
unar - https://theunarchiver.com/

```
require './lib/eivu'
Eivu::VgData::Loader.setup
Eivu::VgData::Utils.inspect_library(path_to_rom)
Eivu::VgData::Utils.extract_all(path_to_rom)
Eivu::VgData::Models::Game.slugify_rom(path_to_rom_file)
Eivu::VgData::Models::Game.slugify_string(path_to_rom_file)
Eivu::VgData::Models::Game.find_rom_info(path_to_rom)
Eivu::VgData::Debug.inspect_library(path_to_roms)
```

note:1-(2808/11002.0)
