class Ls

	def initialize(kernel, args)
		files = Dir["#{kernel.env_vars[:current_path]}/#{args.first}/*"]
		files.each do |file|
			if File.directory?(file)
				kernel.screen.print("/#{File.basename(file)} (permissions: d#{kernel.filesystem.permissions_to_text(kernel.filesystem.permissions_for_file_directory(file))}, #{kernel.filesystem.permissions_for_file_directory(file)})")
			else
				kernel.screen.print("#{File.basename(file)} (permissions: -#{kernel.filesystem.permissions_to_text(kernel.filesystem.permissions_for_file_directory(file))}, #{kernel.filesystem.permissions_for_file_directory(file)})")
			end
		end
		
	end

end