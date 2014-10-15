class Scene
  @@scenes = {}
  
  @@current_scene_name = nil

  @@shipscore = 0;
  @@pazuruscore = 0;


  def self.add_scene(scene_obj, scene_name)
    @@scenes[scene_name.to_sym] = scene_obj
  end


  def self.set_current_scene(scene_name)
    @@current_scene_name = scene_name.to_sym
  end


  def self.play_scene
    @@scenes[@@current_scene_name].play
  end

  def self.ship_score_set(score)
    @@shipscore = score
  end

  def self.ship_score
    @@shipscore
  end
  def self.pazuru_score_set(score)
    @@pazuruscore = score
  end

  def self.pazuru_score
    @@pazuruscore
  end  
end