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
		string1 = string.gsub(/\\n/, "")
		File.open('processed-apply.rb', 'w') do |file|
			file.write(Base64.decode64(string1))
			file.close
		end
	end
end

File.open('processed-apply.rb', 'r').each_line do |line|
	next_string = line[pattern]
	puts "#{next_string}"

	if next_string.class == String then
		next_string1 = next_string.gsub(/\\n/, "")
		puts "#{next_string}"
		File.open('processed-apply1.rb', 'w') do |file|
			file.write(Base64.decode64(next_string1))
			file.close
		end
	end
end