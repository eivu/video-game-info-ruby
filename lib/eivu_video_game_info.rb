# frozen_string_literal: true

require_relative "eivu_video_game_info/version"

require 'zeitwerk'
loader = Zeitwerk::Loader.for_gem
loader.setup # ready!



module EivuVideoGameInfo
  class Error < StandardError; end

  # def self.greeting
  #   "Hello from EivuVideoGameInfo!"
  # end
end
