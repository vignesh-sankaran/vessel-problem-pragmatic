#!/usr/bin/env ruby

require "base64"
require "open-uri"
pattern = /(?<=")(.+)(?=")/

File.delete('apply.rb') if File.exist?('apply.rb')
File.delete('processed-apply.rb') if File.exist?('processed-apply.rb')

File.open('apply.rb', 'wb') do |file|
	file << open('https://www.vessel.com/careers/apply.rb').read
end

File.open('apply.rb').each_line do |line|
	string = line[pattern]

	if string.class == String then
		File.open('processed-apply.rb', 'wb') do |file|
			file.write(Base64.decode64(string.gsub("\n", "")))
		end
	end
end