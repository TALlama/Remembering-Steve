#!/usr/bin/env ruby -wKU

require 'rubygems'
require 'json'

File.open("messages.txt", "w") do |messages|
	File.open("locations.txt", "w") do |locations|
		Dir.chdir('json') do
			Dir.glob('*.json').each do |file|
				json = JSON.parse(File.read(file))
				
				msg = json["mainText"].
					gsub("\n", " ").
					gsub(/\s*<br>\s*/, '').
					gsub(/&nbsp;/, '').strip
				messages << msg + "\n"
				
				loc = json["location"].
					gsub(/\s*from\s*/, '').
					gsub(/\s*<br>\s*/, '').
					gsub(/&nbsp;/, '').strip
				locations << loc + "\n" if (loc.length > 0)
			end
		end
	end
end