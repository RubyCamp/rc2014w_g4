module Start
  class Director
    def initialize
      @resized = false
      @japan_map = Image.load("images/japan_map.png")
      @icon = Image.load("images/shimanekko_icon.jpg")
      @font = Font.new(10)
	  # 第２引数を省略するとＭＳ Pゴシックになります
    end

    def play
	if !@resized
	  Window.resize( 600, 420 )
	  @resized=true
	  Window.caption = "島根を探し出せ！！"
        end
      Window.draw(0, 0, @japan_map)
      Window.drawFont(0, 410, "島根県観光キャラクター「しまねっこ」",@font,color:[0,0,0])
      x = Input.mousePosX  # マウスカーソルのx座標
      y = Input.mousePosY  # マウスカーソルのy座標
    
        if 106 <= x && x <= 152 && 268 <= y && y <= 298
          Window.draw(x,y,@icon)
           if Input.mousePush?(M_LBUTTON)
             Scene.set_current_scene(:maingamen)
	     @resized = false
	end
	end
    end
  end
end

    # x1   x = 106 ,y = 292
    # x2   x = 112 ,y = 298
    # y1   x = 152 ,y = 268
    # y2   x = 154 ,y = 278
    
