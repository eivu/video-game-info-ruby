require "active_record"

module EivuVideoGameInfo
  module Models
    module Concerns
      module ActiveRecordable
        extend ActiveSupport::Concern

        included do
          ActiveRecord::Base.establish_connection(adapter: "sqlite3",
                                                  database: "../../db/db.sqlite3")
        end
      end
    end
  end
end
