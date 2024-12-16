require 'active_record'

# ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db.sqlite')
module Eivu
  class VgData
    module Models
      module Concerns
        module ActiveRecordable
          extend ActiveSupport::Concern

          included do
            ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: '../../db.sqlite3')
            # def self.acts_as_active_recordable
            #   include ActiveRecordable::InstanceMethods
            # end
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
