require 'tk'

module FrameUtil
  def CenterWindow(window, width, height)
    x = (TkWinfo.screenwidth(window) - width) / 2
    y = (TkWinfo.screenheight(window) - height) / 2
    window['geometry'] = "#{width}x#{height}-#{x}+#{y}"
  end
end
