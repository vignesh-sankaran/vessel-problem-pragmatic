#!/usr/bin/env ruby

require "base64"
require "open-uri"

def loop_base64_decoder()
	pattern = /(?<=")(.+)(?=")/
	loop do
		if !File.exist?('processed_apply.rb') then
			file_name = "apply.rb"
		else
			file_name = "processed_apply.rb"
		end

		base64 = ""

		File.open(file_name).each_line do |line|
			string = line[pattern]

			if string.class == String && string.include?("\\n") then
				string = string.gsub(/\\n/, "")
				base64 = string
				File.open("current_solutions.txt", "a") do |file|
					file.write(string + "\n\n")
					file.close
				end
			end
		end

		break if base64 == ""

		File.open("processed_apply.rb", "w+") do |file|
			file.write(Base64.decode64(base64))
			file.close
		end
	end
end

def main()

	File.delete('apply.rb') if File.exist?('apply.rb')
	File.delete('processed_apply.rb') if File.exist?('processed_apply.rb')

	File.open('apply.rb', 'wb') do |file|
		file << open('https://www.vessel.com/careers/apply.rb').read
	end

	loop_base64_decoder()

end

main()