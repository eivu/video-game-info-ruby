require 'pry'
require 'active_record'

module Eivu
  class VgData
    class Loader
      include Eivu::VgData::Models::Concerns::ActiveRecordable

      ROM_FORMATS = {
        '3DO Interactive Multiplayer' => %w[],
        'Commodore Amiga' => %w[],
        'Amstrad CPC' => %w[],
        'Android' => %w[apk],
        'Arcade' => %w[],
        'Atari 2600' => %w[a26],
        'Atari 5200' => %w[a52],
        'Atari 7800' => %w[a78],
        'Atari Jaguar' => %w[jag],
        'Atari Jaguar CD' => %w[],
        'Atari Lynx' => %w[lnx],
        'Atari XEGS' => %w[],
        'ColecoVision' => %w[col],
        'Commodore 64' => %w[],
        'Mattel Intellivision' => %w[],
        'Apple iOS' => %w[ipa],
        'Apple Mac OS' => %w[],
        'Microsoft Xbox' => %w[],
        'Microsoft Xbox 360' => %w[],
        'Microsoft Xbox One' => %w[],
        'SNK Neo Geo Pocket' => %w[ngp],
        'SNK Neo Geo Pocket Color' => %w[ngc],
        'SNK Neo Geo AES' => %w[],
        'Nintendo 3DS' => %w[3ds],
        'Nintendo 64' => %w[v64 z64 n64],
        'Nintendo DS' => %w[nds],
        'Nintendo Entertainment System' => %w[nes bsv nez unf unif]],
        'Nintendo Game Boy' => %w[gb],
        'Nintendo Game Boy Advance' => %w[gba srl],
        'Nintendo Game Boy Color' => %w[gbc],
        'Nintendo GameCube' => %w[gcm gcz iso],
        'Nintendo Virtual Boy' => %w[vb],
        'Nintendo Wii' => %w[wad wbfs],
        'Nintendo Wii U' => %w[],
        'Ouya' => %w[],
        'Philips CD-i' => %w[],
        'Sega 32X' => %w[32x],
        'Sega CD' => %w[],
        'Sega Dreamcast' => %w[],
        'Sega CD' => %w[],
        'Sega Dreamcast' => %w[],
        'Sega Game Gear' => %w[gg],
        'Sega Genesis' => %w[gen],
        'Sega Master System' => %w[sms],
        'Sega Saturn' => %w[],
        'Sinclair ZX Spectrum' => %w[],
        'Sony Playstation' => %w[],
        'Sony Playstation 2' => %w[],
        'Sony Playstation 3' => %w[],
        'Sony Playstation 4' => %w[],
        'Sony Playstation Vita' => %w[],
        'Sony PSP' => %w[],
        'Super Nintendo Entertainment System' => %w[sfc smc],
        'NEC TurboGrafx-16' => %w[pce],
        'WonderSwan' => %w[ws],
        'WonderSwan Color' => %w[wsc],
        'Magnavox Odyssey 2' => %w[],
        'Fairchild Channel F' => %w[],
        'BBC Microcomputer System' => %w[],
        'Memotech MTX512' => %w[],
        'Camputers Lynx' => %w[],
        'Tiger Game.com' => %w[],
        'Oric Atmos' => %w[],
        'Acorn Electron' => %w[],
        'Dragon 32/64' => %w[],
        'Entex Adventure Vision' => %w[],
        'APF Imagination Machine' => %w[],
        'Mattel Aquarius' => %w[],
        'Jupiter Ace' => %w[],
        'SAM Coupé' => %w[],
        'Enterprise' => %w[],
        'EACA EG2000 Colour Genie' => %w[],
        'Acorn Archimedes' => %w[],
        'Tapwave Zodiac' => %w[],
        'Atari ST' => %w[],
        'Bally Astrocade' => %w[],
        'Magnavox Odyssey' => %w[],
        'Emerson Arcadia 2001' => %w[],
        'Sega SG-1000' => %w[],
        'Epoch Super Cassette Vision' => %w[],
        'Microsoft MSX' => %w[],
        'MS-DOS' => %w[],
        'Windows' => %w[],
        'Web Browser' => %w[],
        'Sega Model 2' => %w[],
        'Namco System 22' => %w[],
        'Sega Model 3' => %w[],
        'Sega System 32' => %w[],
        'Sega System 16' => %w[],
        'Sammy Atomiswave' => %w[],
        'Sega Naomi' => %w[],
        'Sega Naomi 2' => %w[],
        'Atari 800' => %w[],
        'Sega Model 1' => %w[],
        'Sega Pico' => %w[],
        'Acorn Atom' => %w[],
        'Amstrad GX4000' => %w[],
        'Apple II' => %w[],
        'Apple IIGS' => %w[],
        'Casio Loopy' => %w[],
        'Casio PV-1000' => %w[],
        'Coleco ADAM' => %w[],
        'Commodore 128' => %w[],
        'Commodore Amiga CD32' => %w[],
        'Commodore CDTV' => %w[],
        'Commodore Plus 4' => %w[],
        'Commodore VIC-20' => %w[],
        'Fujitsu FM Towns Marty' => %w[],
        'GCE Vectrex' => %w[],
        'Nuon' => %w[],
        'Mega Duck' => %w[],
        'Sharp X68000' => %w[],
        'Tandy TRS-80' => %w[],
        'Elektronika BK' => %w[],
        'Epoch Game Pocket Computer' => %w[],
        'Funtech Super Acan' => %w[],
        'GamePark GP32' => %w[],
        'Hartung Game Master' => %w[],
        'Interton VC 4000' => %w[],
        'MUGEN' => %w[],
        'OpenBOR' => %w[],
        'Philips VG 5000' => %w[],
        'Philips Videopac+' => %w[],
        'RCA Studio II' => %w[],
        'ScummVM' => %w[],
        'Sega Dreamcast VMU' => %w[],
        'Sega SC-3000' => %w[],
        'Sega ST-V' => %w[],
        'Sinclair ZX-81' => %w[],
        'Sord M5' => %w[],
        'Texas Instruments TI 99/4A' => %w[],
        'Pinball' => %w[],
        'VTech CreatiVision' => %w[],
        'Watara Supervision' => %w[],
        'WoW Action Max' => %w[],
        'ZiNc' => %w[],
        'Nintendo Famicom Disk System' => %w[],
        'NEC PC-FX' => %w[],
        'PC Engine SuperGrafx' => %w[],
        'NEC TurboGrafx-CD' => %w[],
        'TRS-80 Color Computer' => %w[],
        'Nintendo Game & Watch' => %w[],
        'SNK Neo Geo CD' => %w[],
        'Nintendo Satellaview' => %w[],
        'Taito Type X' => %w[],
        'XaviXPORT' => %w[],
        'Mattel HyperScan' => %w[],
        'Game Wave Family Entertainment System' => %w[],
        'Sega CD 32X' => %w[],
        'Aamber Pegasus' => %w[],
        'Apogee BK-01' => %w[],
        'Commodore MAX Machine' => %w[],
        'Commodore PET' => %w[],
        'Exelvision EXL 100' => %w[],
        'Exidy Sorcerer' => %w[],
        'Fujitsu FM-7' => %w[],
        'Hector HRX' => %w[],
        'Matra and Hachette Alice' => %w[],
        'Microsoft MSX2' => %w[],
        'Microsoft MSX2+' => %w[],
        'NEC PC-8801' => %w[],
        'NEC PC-9801' => %w[],
        'Nintendo 64DD' => %w[],
        'Nintendo Pokemon Mini' => %w[],
        'Othello Multivision' => %w[],
        'VTech Socrates' => %w[],
        'Vector-06C' => %w[],
        'Tomy Tutor' => %w[],
        'Spectravideo' => %w[],
        'Sony PSP Minis' => %w[],
        'Sony PocketStation' => %w[],
        'Sharp X1' => %w[],
        'Sharp MZ-2500' => %w[],
        'Sega Triforce' => %w[],
        'Sega Hikaru' => %w[],
        'SNK Neo Geo MVS' => %w[],
        'Nintendo Switch' => %w[nsp xci],
        'Windows 3.X' => %w[],
        'Nokia N-Gage' => %w[],
        'GameWave' => %w[],
        'Linux' => %w[],
        'Sony Playstation 5' => %w[],
        'PICO-8' => %w[],
        'VTech V.Smile' => %w[],
        'Microsoft Xbox Series X/S' => %w[],
      }.freeze  

      class << self
        def clean_db_game_names
          Eivu::VgData::Models::Game.find_each do |game|
            puts game.id
            game.update_attribute(:slug, Eivu::VgData::Models::Game.slugify_string(game.name))
          end
        end

        def setup
          # add_newer_columns
          # populate_short_names
          # populate_platform_id_in_games
          # clean_db_game_names
        end

        def populate_platform_id_in_games
          Eivu::VgData::Models::Platform.all.each do |platform|
            Eivu::VgData::Models::Game.where(platform: platform.name).update_all(platform_id: platform.id)
          end
        end

        def populate_short_names
          Eivu::VgData::Models::Platform.update_all('short_name = name')
          %w[Sega Nintendo Commodore Sony Microsoft SNK].each do |string|
            Eivu::VgData::Models::Platform
              .where.not(id: [6, 7, 8, 12, 38, 42, 73, 87, 86, 91, 147])
              .update_all("short_name = replace(short_name, '#{string} ', '')")
          end
        end

        def add_newer_columns
          games_info = ActiveRecord::Base.connection.execute('PRAGMA table_info(games);')
          if games_info.detect{|hash| hash['name'] == 'slug'}.nil?
            ActiveRecord::Base.connection.execute('ALTER TABLE "games" ADD COLUMN "slug" varchar')
          end

          if games_info.detect{|hash| hash['name'] == 'platform_id'}.nil?
            ActiveRecord::Base.connection.execute('ALTER TABLE "games" ADD COLUMN "platform_id" varchar')
          end

          platforms_info = ActiveRecord::Base.connection.execute('PRAGMA table_info(platforms);')
          if platforms_info.detect{|hash| hash['name'] == 'short_name'}.nil?
            ActiveRecord::Base.connection.execute('ALTER TABLE "platforms" ADD COLUMN "short_name" varchar;')
          end
        end

        def create_platform_roms_format_table
          ActiveRecord::Base.connection.execute('CREATE TABLE "platform_roms_formats" ("id" integer,"platform_id" int, PRIMARY KEY (id));')
        end
      end
    end
  end
end
