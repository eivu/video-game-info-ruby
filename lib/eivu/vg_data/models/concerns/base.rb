require 'active_record'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'test.db')

module ActiveRecordable
  extend ActiveSupport::Concern

  included do
    def self.acts_as_active_recordable
      include ActiveRecordable::InstanceMethods
    end
  end

  module InstanceMethods
    def save
      # save the record
    end
  end
end