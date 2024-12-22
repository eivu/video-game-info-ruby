require 'active_record'
require 'pry'

module Eivu
  class VgData
    module Models
      class Game < ::ActiveRecord::Base
        include Eivu::VgData::Models::Concerns::ActiveRecordable
        
        belongs_to :platform

        # full list including disc based systems at 
        # https://gist.github.com/dabobert/00f23d168a0f4c861d3d2dbea83f2b37
        FORMATS = [
          # FORMAT_3DO = ['cue', 'iso'].freeze,
          FORMAT_ATARI2600 = %w[a26].freeze,
          FORMAT_ATARI5200 = %w[a52].freeze,
          FORMAT_ATARI7800 = %w[a78].freeze,
          FORMAT_COLECOVISION = %w[col].freeze,
          FORMAT_FAMICOM = %w[nes].freeze,
          FORMAT_FINALBURNALPHA_2016 = %w[dat].freeze,
          FORMAT_FINALBURNALPHA = %w[fs].freeze,
          FORMAT_GENESIS = %w[gen 32x].freeze,
          FORMAT_INTELLIVISION = %w[int].freeze,
          FORMAT_JAGUAR = %w[jag].freeze,
          FORMAT_LYNX = %w[lnx].freeze,
          # FORMAT_MSX1 = %w[zip].freeze,
          # FORMAT_MSX2 = %w[zip].freeze,
          # FORMAT_MTX512 = %w[zip].freeze,
          FORMAT_NES = %w[nes bsv].freeze,
          # FORMAT_NEOGEO = %w[zip].freeze,
          # FORMAT_NEOGEOCD = %w[zip].freeze,
          FORMAT_NEOGEOPOCKET = %w[ngp].freeze,
          FORMAT_NEOGEOPOCKETCOLOR = %w[ngc].freeze,
          FORMAT_NINTENDO3DS = %w[3ds].freeze,
          FORMAT_NINTENDO64 = %w[v64 z64 n64].freeze,
          FORMAT_NINTENDODS = %w[7z].freeze,
          # FORMAT_PSP = %w[iso rar filepart].freeze,
          FORMAT_PORTS = %w[wad rts grp pak sh].freeze,
          # FORMAT_SG_1000 = %w[zip].freeze,
          FORMAT_SNES = %w[sfc smc].freeze,
          # FORMAT_SEGAMASTERSYSTEM = %w[zip].freeze,
          FORMAT_TURBOGRAFX16 = %w[pce].freeze,
          # FORMAT_VECTREX = %w[zip].freeze,
          FORMAT_VIRTUALBOY = %w[vb].freeze,
          FORMAT_WONDERSWAN = %w[ txt sav].freeze,
          FORMAT_WONDERSWANCOLOR = %w[ sav].freeze,
          FORMAT_GAMEBOY = %w[srm gb].freeze,
          FORMAT_GAMEBOYADVANCE = %w[gba mb e+ bin].freeze,
          FORMAT_GAMEBOYCOLOR = %w[gb gbc cgb sgb].freeze,
          # FORMAT_GAMEGEAR = %w[zip].freeze,
        ].flatten.freeze

        # order matters for the array below
        # will be run in order they are defined
        REPLACE_RULES_LIST = [
          REGEX_COUNTRY  = /\(([^)]+)\)/, # replace (value)
          REGEX_MISC_TAG = /\[([^)]+)\]/, # replace [value]
          RULE_THE_MID = ' the '.freeze,
          RULE_THE_START = /^the /,
          RULE_AND = ' and '.freeze,
          RULE_DISNEYS = 'disney\'s'.freeze,
          RULE_SPECIAL_CHARS = /[^a-z0-9]/
        ]

        class << self
          def extract_country(rom_name)
            case rom_name.scan(COUNTRY_REGEX).flatten&.first
            when 'U'
              'USA'
            when 'J'
              'Japan'
            when 'E'
              'Europe'
            when 'K'
              'Korea'
            when nil
              nil
            else
              'Unknown'
            end
          end

          def slugify_string(string)
            value = string.dup.downcase
            REPLACE_RULES_LIST.each { |rule| value.gsub!(rule, '') }
            value
          end

          def slugify_rom(rom_name)
            slugify_string(File.basename(rom_name, '.*'))
          end
        end
      end
    end
  end
end
