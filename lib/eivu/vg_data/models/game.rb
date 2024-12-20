require 'active_record'
require 'pry'

module Eivu
  class VgData
    module Models
      class Game < ::ActiveRecord::Base
        include Eivu::VgData::Models::Concerns::ActiveRecordable

        REGEX_LIST = [
          REGEX_THE = ', the',
          REGEX_AND = ' and ',
          
          REGEX_COUNTRY = /\(([^)]+)\)/,
          REGEX_MISC_TAG= /\[([^)]+)\]/
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

          def sanitize_rom(rom_name)
            name = File.basename(rom_name, '.*')]
            name.gsub!(COUNTRY_REGEX, '')
            name.gsub!(MISC_TAG_REGEX, '')
            name.downcase!
            name.gsub!(AND, '')
            name = "the #{name.gsub(THE, '')}" if name.include?(THE)
            name.gsub!(/[^a-z0-9]/, '')
            name
          end
        end
      end
    end
  end
end
