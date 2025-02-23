# frozen_string_literal: true

Gem::Specification.new do |s|
  s.authors = ['Robert Jenkins']
  s.email   = ['384403+dabobert@users.noreply.github.com']

  s.name = 'eivu-video-game-info'
  s.version = '1.1.1'

  s.license          = 'MIT'
  s.homepage         = 'https://github.com/eivu/video-game-info-ruby'

  s.platform = Gem::Platform::RUBY
  s.summary = 'Ruby gem to retrieve video game info of video game roms'
  s.description = <<-MARKDOWN
    ruby client for parsing data sourced from [https://www.launchbox-app.com/](https://www.launchbox-app.com/)

    Only Supporting Cartridges for Rom format matching, Disc based system are all .bin, .cue, and .iso.
    Not only impossible to distinguish but is not supported on the browser rom emulator
  MARKDOWN

  s.files         = Dir['{config,lib}/**/*', 'CHANGELOG.md', 'MIT-LICENSE', 'README.md']
  s.require_paths = ['lib']
  s.required_ruby_version = '>= 3.2.5'

  s.add_dependency 'activerecord', '~> 7.2', '>= 7.2.2.1'
  s.add_dependency 'activesupport', '~> 7.2', '>= 7.2.2.1'
  s.add_dependency 'nokogiri', '~> 1.17', '>= 1.17.2'
  s.add_dependency 'rspec', '~> 3.13'
  s.add_dependency 'rubocop', '~> 1.57', '>= 1.57.2'
  s.add_dependency 'sqlite3', '~> 2.0', '>= 2.0.2'
  s.add_dependency 'zeitwerk', '~> 2.6', '>= 2.6.12'
  s.metadata['rubygems_mfa_required'] = 'true'
end
