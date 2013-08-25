require 'fileutils'

class Configuration
	@@_directory = '~\\AppData\\Roaming\\PhraseFinder\\'
	@@_filename = @@_directory + 'settings.dat'

	attr_accessor :rootDirectory
	attr_accessor :editorPath
	attr_accessor :excludedFolders
	attr_accessor :extensions

	def Save
		unless File.directory?(@@_directory)
			FileUtils.mkdir_p(@@_directory)
		end
		File.open(@@_directory + @@_filename, 'w') do |file|
			file.print Marshal.dump(self)
		end
	end
  
	def self.Load
		if File.exists?(@@_directory + @@_filename)
			File.open(@@_directory + @@_filename, 'r') do |file|
				Marshal.load(file)
			end
		end
	end
end
