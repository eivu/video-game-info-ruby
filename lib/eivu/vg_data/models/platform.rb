require 'active_record'

module Eivu
  class VgData
    module Models
      class Platform < ::ActiveRecord::Base
        include Eivu::VgData::Models::Concerns::ActiveRecordable
      end
    end
  end
end
