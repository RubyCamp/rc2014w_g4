require_relative 'start'
require_relative 'home/maingamen'
require_relative 'home/rankinng_ship'
require_relative 'home/rankinng_puzz'
require_relative 'ship/shipMain'
require_relative 'suraido/test_1'

Scene.add_scene(Start::Director.new,  :start)
Scene.add_scene(Maingamen::Director.new,  :maingamen)
Scene.add_scene(Ranking_Ship::Director.new,  :rankinng_ship)
Scene.add_scene(Ranking_Puzz::Director.new,  :rankinng_pazuru)
Scene.add_scene(ShipMain::Director.new,  :shipmain)
Scene.add_scene(PazuruMain::Director.new,  :pazurumain)
