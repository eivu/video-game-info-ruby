require 'active_record'
require 'pry'

module Eivu
  class VgData
    module Models
      class Game < ::ActiveRecord::Base
        include Eivu::VgData::Models::Concerns::ActiveRecordable

        COUNTRY_REGEX = /\(([^)]+)\)/

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


          def sanitize_rom(rom_name)
            name = File.basename(rom_name, '.*')
            name = name.downcase
            name = name.gsub(COUNTRY_REGEX, '')
            name = name.gsub(/[^a-z0-9]/, '')
            name
          end
        end
      end
    end
  end
end
