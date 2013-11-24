require 'yaml'

class Configuration
	@@_directory = File.expand_path '~\\AppData\\Roaming\\PhraseFinder_Ruby\\'
	@@_filename = File.join @@_directory, 'settings.dat'

	attr_accessor :rootDirectory
	attr_accessor :editorPath
	attr_accessor :excludedFolders
	attr_accessor :extensions

	def Save
		unless File.directory?(@@_directory)
			FileUtils.mkdir_p(@@_directory)
		end
		File.open(@@_filename, 'wb') do |file|
			file << YAML.dump(self)
		end
	end
  
	def self.Load
		if File.exists?(@@_filename)
			File.open(@@_filename, 'rb') do |file|
				YAML.load(file.read)
			end
		else
			conf = self.new
			conf.rootDirectory = "C:\\"
			conf.editorPath = ""
			conf.excludedFolders = []
			conf.extensions = []
			conf
		end
	end
end
