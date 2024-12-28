require 'active_record'
require 'pry'

module Eivu
  class VgData
    module Models
      class PlatformFormat < ::ActiveRecord::Base
        include Eivu::VgData::Models::Concerns::ActiveRecordable

        # full list including disc based systems at
        # https://gist.github.com/dabobert/00f23d168a0f4c861d3d2dbea83f2b37
        FORMATS = [
          FORMAT_ATARI2600 = %w[a26].freeze,
          FORMAT_ATARI5200 = %w[a52].freeze,
          FORMAT_ATARI7800 = %w[a78].freeze,
          FORMAT_COLECOVISION = %w[col].freeze,
          FORMAT_FAMICOM = %w[nes].freeze,
          FORMAT_GAMEBOY = %w[srm gb].freeze,
          FORMAT_GAMEBOYADVANCE = %w[gba mb e+].freeze,
          FORMAT_GAMEBOYCOLOR = %w[gb gbc cgb sgb].freeze,
          FORMAT_GAMEGEAR = %w[gg].freeze,
          FORMAT_GENESIS = %w[gen].freeze,
          FORMAT_INTELLIVISION = %w[int].freeze,
          FORMAT_JAGUAR = %w[jag].freeze,
          FORMAT_LYNX = %w[lnx].freeze,
          FORMAT_NES = %w[nes bsv].freeze,
          FORMAT_NEOGEOPOCKET = %w[ngp].freeze,
          FORMAT_NEOGEOPOCKETCOLOR = %w[ngc].freeze,
          FORMAT_NINTENDO3DS = %w[3ds].freeze,
          FORMAT_NINTENDO64 = %w[v64 z64 n64].freeze,
          FORMAT_NINTENDODS = %w[nds].freeze,
          FORMAT_SEGA32X = %w[32x].freeze,
          FORMAT_SNES = %w[sfc smc].freeze,
          FORMAT_TURBOGRAFX16 = %w[pce].freeze,
          FORMAT_VIRTUALBOY = %w[vb].freeze
        ].flatten.freeze
      end
    end
  end
end
