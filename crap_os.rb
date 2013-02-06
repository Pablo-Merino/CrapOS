# encoding: utf-8
require 'active_support/core_ext/string'


module CrapOS; end

File.tap do |f|
	Dir[f.expand_path(f.join(f.dirname(__FILE__),'lib', 'crap_os', '**/*.rb'))].each do |file|

		CrapOS.autoload File.basename(file, '.rb').camelize, file
	end
end

