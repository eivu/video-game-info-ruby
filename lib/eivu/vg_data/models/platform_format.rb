require 'active_record'
require 'pry'

module Eivu
  class VgData
    module Models
      class PlatformFormat < ::ActiveRecord::Base
        include Eivu::VgData::Models::Concerns::ActiveRecordable
      end
    end
  end
end