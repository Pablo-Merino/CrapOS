module CrapOS

	class Kernel
		attr_reader :env_vars, :filesystem
		def initialize(arguments, screens, current_scr, &block)
			@current_screen = current_scr
			@screens = screens
			@env_vars = {:path => [], :current_path => "#{File.expand_path(arguments[:root_path])}"}
			
			if arguments[:root_path]
				@env_vars[:root_path] = File.expand_path(arguments[:root_path])

				@filesystem = Filesystem.new(File.expand_path(arguments[:root_path]), screen, self)
			else
				raise "DAFUQ is this shit"
			end

			yield self if block_given?
		end

		def screen
			@screens[@current_screen-1]
		end

		def change_screen(id)
			if @screens.length >= id
				@current_screen = id
			else
				screen.error("screen index out of range")
			end
		end

		def execute_program(path, &block)
			found = false
			full_path = ""
			@env_vars[:path].each do |p|

				if File.exists?("#{@filesystem.root_path}/#{p}/#{path}.rb")
					found = true
					full_path = "#{@filesystem.root_path}/#{p}/#{path}.rb"
				end

			end
			if found
				require full_path
				deployer_object = Object.const_get("#{File.basename(full_path).gsub(".rb", "").camelize}")

				yield deployer_object if block_given?
			else
				yield nil if block_given?
			end
		end

	end

end
