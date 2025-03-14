require 'active_record'
require 'active_support/all'
require 'pry'

module Eivu
  class VgData
    module Models
      class Game < ::ActiveRecord::Base
        include Eivu::VgData::Models::Concerns::ActiveRecordable

        belongs_to :platform

        # order matters for the array below
        # will be run in order they are defined
        SLUGIFY_RULES_LIST = [
          REGEX_COUNTRY  = /\(([^)]+)\)/, # replace (value)
          REGEX_MISC_TAG = /\[([^)]+)\]/, # replace [value]
          RULE_THE_MID = ' the '.freeze,
          RULE_THE_START = /^the /,
          RULE_GBS_PLAYER = /gbs player v\d+(\.\d+)? -/,
          RULE_AND = ' and '.freeze,
          RULE_DISNEYS = 'disney\'s'.freeze,
          RULE_SPECIAL_CHARS = /[^a-z0-9]/
        ].freeze

        SLUGIFY_SECONDARY_RULES_LIST = [
          RULE_GBS_PLAYER,
          REGEX_VERSION = /v\d+(\.\d+)?[a-b]?/
        ]

        LEADING_DIGITS = /^(\d{4})/

        class << self
          def extract_country(rom_name)
            case rom_name.scan(REGEX_COUNTRY).flatten&.first
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

          def fetch_rom_info(filename)
            format = File.extname(filename).delete('.')
            platform_id = PlatformFormat.find_by(format:)&.platform_id
            return nil if platform_id.nil?

            slugs = [slugify_rom(filename), slugify_rom_xtra(filename)]
            # try to find an exact match of the slug via either slug
            slugs.detect do |slug|
              game = Game.find_by(slug:, platform_id:)
              return game if game.present?

              slug.gsub!(LEADING_DIGITS, '')
              Game.find_by(slug:, platform_id:)
            end

            # if no exact match, return a match if there is only a single partial match
            slugs.detect do |slug|
              matches = Game.where(platform_id:).where('slug like ?', "#{slug}%")
              return matches.first if matches.size == 1

              slug.gsub!(LEADING_DIGITS, '')
              matches = Game.where(platform_id:).where('slug like ?', "#{slug}%")
              return matches.first if matches.size == 1
            end
          end

          def fetch_rom_info_as_json(filename)
            fetch_rom_info(filename)&.as_json
          end

          def slugify_string(string)
            value = I18n.transliterate(string.dup.downcase.gsub('_', ' '))
            SLUGIFY_RULES_LIST.each { |rule| value.gsub!(rule, '') }
            value
          end

          def slugify_string_xtra(string)
            value = I18n.transliterate(string.dup.downcase.gsub('_', ' '))

            (SLUGIFY_SECONDARY_RULES_LIST + SLUGIFY_RULES_LIST).each { |rule| value.gsub!(rule, '') }
            value
          end

          def slugify_rom(rom_name)
            slugify_string(File.basename(rom_name, '.*'))
          end

          def slugify_rom_xtra(rom_name)
            slugify_string_xtra(File.basename(rom_name, '.*'))
          end
        end

        def as_json(options = {})
          response = attributes&.symbolize_keys
          response[:platform] = platform.short_name
          response
        end
      end
    end
  end
end
