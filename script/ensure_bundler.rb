#!/usr/bin/env ruby
require 'rubygems'

app_root = File.expand_path('..', __dir__)
lockfile_path = File.join(app_root, 'Gemfile.lock')

unless File.exist?(lockfile_path)
  warn "Gemfile.lock not found at #{lockfile_path}"
  exit 1
end

lockfile_lines = File.readlines(lockfile_path, chomp: true)
bundled_with_index = lockfile_lines.index('BUNDLED WITH')
required_version = lockfile_lines[(bundled_with_index || -1) + 1..]&.find { |line| !line.strip.empty? }&.strip

unless required_version
  warn 'Could not determine the required Bundler version from Gemfile.lock.'
  exit 1
end

if Gem::Specification.find_all_by_name('bundler', required_version).any?
  puts "Bundler #{required_version} already available."
  exit 0
end

puts "Installing Bundler #{required_version}..."
success = system('gem', 'install', 'bundler', '-v', required_version, '--conservative')
exit(success ? 0 : 1)
