require 'active_record'

module Eivu
  class VgData
    module Models
      class Game < ::ActiveRecord::Base
        include Eivu::VgData::Models::Concerns::ActiveRecordable

      end
    end
  end
end

# Eivu::VGData::Models::Game.establish_connection(adapter: 'sqlite3', database: 'test.db')