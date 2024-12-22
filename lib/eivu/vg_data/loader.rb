require 'pry'
require 'active_record'

module Eivu
  class VgData
    class Loader
      include Eivu::VgData::Models::Concerns::ActiveRecordable

      class << self
        def clean_db_game_names
          Eivu::VgData::Models::Game.find_each do |game|
            puts game.id
            game.update_attribute(:slug, Eivu::VgData::Models::Game.slugify_string(game.name))
          end
        end

        def setup
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
          Eivu::VgData::Models::Platform.update_all('short_name = name')
          %w[Sega Nintendo Commodore Sony Microsoft SNK].each do |string|
            Eivu::VgData::Models::Platform
              .where.not(id: [6, 7, 8, 12, 38, 42, 73, 87, 86, 91, 147])
              .update_all("short_name = replace(short_name, '#{string} ', '')")
          end
          populate_platform_id_in_games
          clean_db_game_names
        end

        def populate_platform_id_in_games
          Eivu::VgData::Models::Platform.all.each do |platform|
            Eivu::VgData::Models::Game.where(platform: platform.name).update_all(platform_id: platform.id)
          end
        end
      end
    end
  end
end
