class Cat

	def initialize(kernel, args)
		kernel.filesystem.read("#{kernel.env_vars[:current_path]}/#{args.first}") do |t|
			kernel.screen.print(t)
		end
	end

end