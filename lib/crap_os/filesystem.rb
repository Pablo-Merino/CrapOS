module CrapOS

	class Filesystem
		attr_reader :root_path
		def initialize(root_path, screen, kernel)
			@screen = screen
			@root_path = root_path
			@kernel = kernel
			@screen.debug("#{@root_path}")

			analyze_root_dir(@root_path)
		end

		def read(file, &block)
			if is_in_root?(file)
				yield File.open(file).read if block_given?
			else
				@screen.error("ERROR: File unaccesible")
			end
		end

		def is_in_root?(path)
			path.starts_with?(@root_path) if path.is_a?(String)
		end

		def analyze_root_dir(dir)
			files = Dir["#{dir}*/**"]
			files.each do |file|
				if File.directory?(file)
					if ['bin', 'root'].include?(File.basename(file))
						if File.basename(file) == 'bin'
							@kernel.env_vars[:path] << '/bin'
						end
						@screen.info("#{file}: directory and needed")
					else
						@screen.info("#{file}: directory but not needed")
					end
				else
					@screen.info("#{file}: not a directory")
				end
			end
			
		end

		def permissions_to_text(perms)
			permissions = ""
			perms.split("").each do |p|

				case p.to_i
				when 0
					permissions << "---"
				when 1
					permissions << "--x"
				when 2
					permissions << "-w-"
				when 3
					permissions << "-wx"
				when 4
					permissions << "r--"
				when 5
					permissions << "r-x"
				when 6
					permissions << "rw-"
				when 7
					permissions << "rwx"
				
				end
			end
			permissions
		end

		def permissions_for_file_directory(path)
			if File.directory?(path)
				File.stat(path).mode.to_s(8)[2..5]
			else
				File.stat(path).mode.to_s(8)[3..5]
			end
		end

	end

end