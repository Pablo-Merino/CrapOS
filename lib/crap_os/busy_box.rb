module CrapOS

	class BusyBox
		def initialize(screen, env, kernel)
			require 'readline'
			@screen = screen
			@kernel = kernel
			loop do
				@screen.debug("#{@kernel.env_vars}")
				cmd = Readline.readline("#{@kernel.class.to_s}# ", true)
				cmd, *args = cmd.split(" ")
				@kernel.execute_program("#{cmd}") do |class_instance|
					if class_instance
						@screen.debug("#{class_instance}")
						class_instance.new(@kernel, args)
					else
						@screen.error("command not found")
					end
				end
				

			end
		end
	end

end