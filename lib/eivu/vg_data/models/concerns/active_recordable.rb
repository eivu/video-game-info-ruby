require 'active_record'

module Eivu
  class VgData
    module Models
      module Concerns
        module ActiveRecordable
          extend ActiveSupport::Concern

          included do
            ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'lib/eivu/vg_data/db/db.sqlite3')
          end

          # module InstanceMethods
          #   def save
          #     # save the record
          #   end
          # end
        end
      end
    end
  end
end
