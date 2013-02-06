class Cd

	def initialize(kernel, args)
		if args.first[0] == "/"
			path = File.expand_path("#{kernel.filesystem.root_path}/#{args.first}")
			if kernel.filesystem.is_in_root?(path)
				kernel.screen.debug "changed - #{path}"
				kernel.env_vars[:current_path] = path
			else
				kernel.screen.debug "nope"
			end
		else
			path = File.expand_path("#{kernel.env_vars[:current_path]}/#{args.first}")
			if kernel.filesystem.is_in_root?(path) and File.exists?(path)
				kernel.screen.debug "changed - #{path}"
				kernel.env_vars[:current_path] = path
			else
				kernel.screen.debug "nope"
			end
		end
			
	end

end