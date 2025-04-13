require "active_record"

module EivuVideoGameInfo
  module Models
    module Concerns
      module ActiveRecordable
        extend ActiveSupport::Concern

        included do
          ActiveRecord::Base.establish_connection(adapter: "sqlite3",
                                                  database: File.expand_path("../../db/db.sqlite3", __dir__))
        end
      end
    end
  end
end
