#!/usr/bin/env ruby
require 'rbconfig'

app_root = File.expand_path('..', __dir__)
ruby_version_path = File.join(app_root, '.ruby-version')

unless File.exist?(ruby_version_path)
  warn ".ruby-version not found at #{ruby_version_path}"
  exit 1
end

required_version = File.read(ruby_version_path).strip

if required_version.empty?
  warn "No Ruby version found in #{ruby_version_path}"
  exit 1
end

if RUBY_VERSION == required_version
  puts "Ruby #{required_version} already active."
  exit 0
end

warn <<~MSG
  Expected Ruby #{required_version}, but the current shell is using Ruby #{RUBY_VERSION} at #{RbConfig.ruby}.

  Activate the repository runtime before continuing.

  If you use mise:
    mise exec ruby@#{required_version} -- <command>
    mise use -g ruby@#{required_version}
MSG

exit 1
