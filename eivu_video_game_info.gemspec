# frozen_string_literal: true

require_relative "lib/eivu_video_game_info/version"

Gem::Specification.new do |spec|
  spec.name = "eivu_video_game_info"
  spec.version = EivuVideoGameInfo::VERSION
  spec.authors = ["Rob Jenkins"]
  spec.email = ["384403+dabobert@users.noreply.github.com"]

  spec.summary = "Ruby gem to retrieve video game info of video game roms"
  spec.description = <<-MARKDOWN
    ruby client for parsing data sourced from [https://www.launchbox-app.com/](https://www.launchbox-app.com/)

    Only Supporting Cartridges for Rom format matching, Disc based system are all .bin, .cue, and .iso.
    Not only impossible to distinguish but is not supported on the browser rom emulator
  MARKDOWN
  spec.homepage = "https://github.com/eivu/video-game-info-ruby"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.5"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/eivu/video-game-info-ruby"
  spec.metadata["changelog_uri"] = "https://github.com/eivu/video-game-info-ruby/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", ">= 6.1.4", "< 8.0"
  spec.add_dependency "nokogiri", "~> 1.17", ">= 1.17.2"
  spec.add_dependency "rspec", "~> 3.13"
  spec.add_dependency "rubocop", "~> 1.57", ">= 1.57.2"
  spec.add_dependency "sqlite3", "~> 2.0", ">= 2.0.2"
  spec.add_dependency "zeitwerk", "~> 2.6", ">= 2.6.12"
  spec.metadata["rubygems_mfa_required"] = "true"
end
