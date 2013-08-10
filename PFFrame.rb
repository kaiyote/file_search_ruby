require 'tk'
require 'tkextlib/tile'
require_relative 'FrameUtil'
include Tk::Tile
include FrameUtil

class PFFrame
  def initialize
    @root = TkRoot.new {title 'Phrase Finder'}
    content = Frame.new(@root) {padding '10 5'}.grid

    Button.new(content) {text 'Browse...'}.grid(:column => 3, :row => 0, :pady => 5, :sticky => 'nsew')

    @root.resizable(false, false)
    CenterWindow(@root, 515, 145)
  end
end
