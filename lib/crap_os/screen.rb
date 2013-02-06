module CrapOS

	class Screen
		attr_reader :history, :id
		def initialize(id = 0, &block)
			@id = id
			@history = []
			yield self if block_given?
		end

		def print(str, log = :no, level = :debug)
			if Logger.is_debug?
				print_str = "#{self.class.to_s}(#{id}) :: #{str}"
			else
				print_str = "#{str}"
			end
			@history << print_str
			if log == :yes
				Logger.send(level, print_str)
				
			else
				puts "#{print_str}"
			end
			
		end

		def fatal(msg)		print 	"#{msg}", :yes, :fatal			end
		def error(msg)		print 	"#{msg}", :yes, :error			end
		def warn(msg)		print 	"#{msg}", :yes, :warn			end
		def info(msg)		print 	"#{msg}", :yes, :info			end
		def debug(msg)		print 	"#{msg}", :yes, :debug			end
		def created(msg)	print 	"#{msg}", :yes, :created		end

		def inspect
			"#<#{self.class.to_s}: history = #{@history}, id = #{@id}>"
		end

	end

end