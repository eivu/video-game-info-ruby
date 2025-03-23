require 'active_record'

module EivuVideoGameInfo
  module Models
    class Platform < ::ActiveRecord::Base
      include EivuVideoGameInfo::Models::Concerns::ActiveRecordable
    end
  end
end
