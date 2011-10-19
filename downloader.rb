#!/usr/bin/env ruby -wKU

require 'net/http'

def download_url_to_file(url, file)
	# strip the url() helper from css definitions
	url[4..(url.length-2)] if url =~ /^url\(/
	
	res = Net::HTTP.get_response(URI.parse(url))
	File.open(file, "w") do |io|
		io << res.body
	end
	file
end

in_dir = File.join(File.dirname(__FILE__), "json")
Dir.mkdir(in_dir) unless File.exists?(in_dir)

10.times do |i|
	url = "http://www.apple.com/stevejobs/messages/#{i}.json"
	puts "##{i}: #{url}"
	download_url_to_file(url, File.join(in_dir, "#{i}.json"))
end
