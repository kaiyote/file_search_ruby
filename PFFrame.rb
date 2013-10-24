require 'tk'
require 'tkextlib/tile'
require_relative 'FrameUtil'
require_relative 'Configuration'
include Tk::Tile
include FrameUtil

class PFFrame
	def initialize
		@conf = Configuration.Load
		TkOption.add '*tearOff', 0
		
		rootProc = Proc.new {self.SetRoot}
		editorProc = Proc.new {self.SetEditor}
		reloadProc = Proc.new {self.Reload}
		saveProc = Proc.new {self.SaveResults}
		searchProc = Proc.new {self.Search}
		stopProc = Proc.new {self.Stop}
		clearProc = Proc.new {self.Clear}
		
		displayFont = TkFont.new("family" => "Segoe UI", "weight" => "bold", "size" => "9")
  
		@root = TkRoot.new {title 'Phrase Finder'}
		content = Frame.new(@root) {padding '10 5'}.grid
		
		menubar = TkMenu.new(@root)
		@root['menu'] = menubar
		
		file = TkMenu.new(menubar)
		menubar.add :cascade, :menu => file, :label => 'File'
		
		file.add :command, :label => 'Set Root', :command => rootProc, :accelerator => 'Ctrl+R'
		file.add :command, :label => 'Set Editor', :command => editorProc, :accelerator => 'Ctrl+P'
		file.add :command, :label => 'Reload File Tree', :command => reloadProc, :accelerator => 'F5'
		file.add :command, :label => 'Save Results', :command => saveProc, :accelerator => 'Ctrl+S'
		file.add :command, :label => 'Exit', :command => proc{exit! true}, :accelerator => 'Ctrl+Q'
		
		@root.bind("Control-KeyRelease-r", rootProc)
		@root.bind("Control-KeyRelease-p", editorProc)
		@root.bind("KeyRelease-F5", reloadProc)
		@root.bind("Control-KeyRelease-s", saveProc)
		@root.bind("Control-KeyRelease-q", proc{exit! true})

		$searchText = TkVariable.new
		$searchFileName = TkVariable.new
		$useRegex = TkVariable.new
		$exclusionList = TkVariable.new
		$extensionList = TkVariable.new
		
		Label.new(content) {text 'Search Term:'; anchor 'center'; font displayFont}.grid(:column => 0, :row => 0, :sticky => 'ew')
		Entry.new(content) {textvariable $searchText; width 34}.grid(:column => 1, :row => 0, :sticky => 'ew', :padx => 5, :columnspan => 3)
		Button.new(content) {text 'Search'; command searchProc}.grid(:column => 4, :row => 0, :sticky => 'ew', :padx => 2)
		Button.new(content) {text 'Stop'; command stopProc}.grid(:column => 5, :row => 0, :sticky => 'ew')
		Label.new(content) {text 'Results'; anchor 'center'; font displayFont; width 47}.grid(:column => 6, :row => 0, :sticky => 'ew', :columnspan => 4)
		Button.new(content) {text 'Clear'; command clearProc}.grid(:column => 10, :row => 0, :sticky => 'ew')
		
		CheckButton.new(content) {text 'Search File Names'; variable $searchFileName; onvalue true; offvalue false}.grid(:column => 0, :row => 1, :sticky => 'ew', :columnspan => 2)
		CheckButton.new(content) {text 'Use Regular Expressions'; variable $useRegex; onvalue true; offvalue false}.grid(:column => 2, :row => 1, :sticky => 'ew', :columnspan => 2)
		@fileTree = Treeview.new(content) {height 20; show 'tree'}.grid(:column => 0, :row => 2, :columnspan => 4, :sticky => 'ew', :pady => 2, :rowspan => 6, :padx => 2)
		
		@resultBox = Treeview.new(content) {height 21; columns 'count'}.grid(:column => 4, :row => 1, :columnspan => 7, :sticky => 'ew', :rowspan => 8, :pady => 2, :padx => 2)
		@resultBox.heading_configure('#0', :text => 'Filename')
		@resultBox.column_configure('#0', :width => 350, :anchor => 'w')
		@resultBox.heading_configure('count', :text => 'Occurences')
		@resultBox.column_configure('count', :width => 1, :anchor => 'center')
		
		Label.new(content) {text 'Exclusions:'; anchor 'center'; font displayFont;}.grid(:column => 0, :row => 8, :sticky => 'ew', :pady => 2)
		Entry.new(content) {textvariable $exclusionList; width 34}.grid(:column => 1, :row => 8, :sticky => 'ew', :padx => 5, :columnspan => 3, :pady => 2)
		Label.new(content) {text 'Extensions:'; anchor 'center'; font displayFont;}.grid(:column => 0, :row => 9, :sticky => 'ew', :pady => 2)
		Entry.new(content) {textvariable $extensionList; width 34}.grid(:column => 1, :row => 9, :sticky => 'ew', :padx => 5, :columnspan => 3, :pady => 2)
		Label.new(content) {text 'Instance Lines'; anchor 'center'; font displayFont;}.grid(:column => 4, :row => 9, :sticky => 'ew', :pady => 2, :columnspan => 7)
		
		@contentBox = Treeview.new(content) {height 5; columns 'count'}.grid(:column => 0, :row => 10, :columnspan => 11, :sticky => 'ew', :pady => 2)
		@contentBox.heading_configure('#0', :text => 'Content')
		@contentBox.column_configure('#0', :width => 700, :anchor => 'w')
		@contentBox.heading_configure('count', :text => 'Line No.')
		@contentBox.column_configure('count', :width => 1, :anchor => 'center')
		
		@root.resizable(false, false)
		CenterWindow(@root, 885, 655)
	end
	
	def SetRoot
		dirname = Tk.chooseDirectory(:initialdir => 'C:\\', :mustexist => true, :parent => @root, :title => 'Choose root for search')
		unless dirname == ""
			@conf.rootDirectory = dirname
			@conf.Save
		end
	end
	
	def SetEditor
		filename = Tk.getOpenFile(:initialdir => 'C:\\', :multiple => false, :parent => @root, :title => 'Select prefered text editor')
		unless filename == ""
			@conf.editorPath = filename
			@conf.Save
		end
	end
	
	def Reload
		
	end
	
	def SaveResults
		
	end
	
	def Search
	
	end
	
	def Stop
	
	end
	
	def Clear
	
	end
end
