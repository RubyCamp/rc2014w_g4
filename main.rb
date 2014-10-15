require 'dxruby'
require 'twitter'
require 'uri'
require 'net/http'
require 'json'
require 'open-uri'
require_relative 'scene'
require_relative 'load_scenes'


Window.caption = "RubyCamp2014 Example"
Window.width   = 800
Window.height  = 600
Window.x=0
Window.y=0
Scene.set_current_scene(:start)

Window.loop do
  break if Input.keyPush?(K_ESCAPE)

  Scene.play_scene
end
