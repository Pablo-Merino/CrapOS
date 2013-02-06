module CrapOS

	class Boot
		def initialize(&block)
			require 'optparse'
			options = {}
			OptionParser.new do |opts|
				opts.banner = "Usage: crap_os [options]"

				opts.on("-r", "--root_dir DIR", "Root Dir") do |v|
					options[:root_path] = v
				end
			end.parse!
			if block_given?
				yield options
			else
				raise 'We need a block nigga!'
			end
		end
	end

end
