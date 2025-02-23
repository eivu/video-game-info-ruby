require 'pry'
require 'csv'
require 'active_support/all'
module Eivu
  class VgData
    class Utils
      class << self
        def clean_db_game_names
          Eivu::VgData::Models::Game.find_each do |game|
            puts game.id
            game.update_attribute(:slug, Eivu::VgData::Models::Game.slugify_string(game.name))
          end
        end

        def inspect_library(path_to_roms = '/Users/jinx/eivu/roms')
          timestamp = Time.now.to_f
          log_path = "logs/roms_status_library.#{timestamp}.csv"
          missing_path = "logs/missing_library.#{timestamp}.csv"
          CSV.open(log_path, 'w+') do |log|
            Dir.glob("#{path_to_roms}/**/*").each do |path_to_rom|
              next if path_to_rom.starts_with?('.') || File.directory?(path_to_rom)

              slug = Eivu::VgData::Models::Game.slugify_rom(path_to_rom)
              game = Eivu::VgData::Models::Game.fetch_rom_info(path_to_rom)
              status = game.nil? ? 'not found' : game.id
              puts "#{status} - #{game&.platform_id}:#{slug} - #{path_to_rom}"
              log << [File.basename(path_to_rom), game&.platform_id, slug, status]
            end
          end
          `cat #{log_path} | grep 'not found' > #{missing_path}`
          `wc -l #{missing_path}`
        end

        def extract_all(path_to_roms``)
          timestamp = Time.now.to_f
          log_path = "logs/extractision.#{timestamp}.csv"
          file = File.open(log_path, 'w+')
          Dir.glob("#{path_to_roms}/**/*").each do |path_to_rom|
            next unless path_to_rom.ends_with?('.zip') || path_to_rom.ends_with?('.7z')

            line = `unar -f -o "#{File.dirname(path_to_rom)}" "#{path_to_rom}"`
            print line
            file.write(line)
          end
          file.close
        end
      end
    end
  end
end
