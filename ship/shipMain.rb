#require 'dxruby'
#require 'uri'
#require 'net/http'
module ShipMain
  class Director
  require_relative 'Button'
  require_relative 'Ship'
  require_relative 'Enemy'
  require_relative 'EnemyController'

  def initialize 
	@UPPRE_RIVER = 125
	@DOWN_RIVER = 490
	@resized = false

	@bg_img1 = Image.load("ship/images/river1.png")
	@bg_img2 = Image.load("ship/images/river2.png")
	@bg_img =@bg_img1
	@btn_green = Button1.new(Window.width.to_i/2,Window.height.to_i/2,"ship/images/startbtn.png")
	@btn_red = Button1.new(Window.width.to_i/2,Window.height.to_i/2,"ship/images/startbtn2.png")
	@loop_bg_counter = 0.0
	@btn = @btn_green
	@count = 1
	@ship = Ship.new
	@font=Font.new(10)
	@enemycon = EnemyController.new(@ship)
  end
  
  def post
	url = URI.parse("http://10.0.1.10:3000/score_ships")#routesのpostの場所から持ってくる
	#url = URI.parse("http://192.168.33.12:3000/score_ships")#routesのpostの場所から持ってくる
	http = Net::HTTP.new(url.host,url.port)
	#http.post(url,"utf8=%E2%9C%93&authenticity_token=ZCd4NPO7nIbAAMXXJIwnjPyygWWvV2HQxgXHHTH3X78%3D&score%5Bname%5D=hogi&score%5Bscore%5D="+enemycon.score.to_s+"&commit=Create+Score")
	http.post(url,"utf8=%E2%9C%93&score_ship%5Bscore%5D="+@enemycon.score.to_s+"&commit=Create+Score+ship")
	@resized=false
  	Scene.ship_score_set(@enemycon.score)
  end

  def play
        if !@resized
	  Window.resize( 640, 600 )
	  @resized=true
	  Window.caption = "遊覧船ゲーム"
	  @enemycon.timer = 2000
	  @enemycon.score = 0
	  @btn_green.is_clicked = false
	  @btn_red.is_clicked = false
	  @ship.isshow = false
	  @enemycon.is_clicked = false
	  @btn.is_clicked = false
	  @loop_bg_counter = 0.0
          @btn = @btn_green
          puts "aaa"
        end
	
	if @enemycon.timer  < 0
                post
		Scene.set_current_scene(:rankinng_ship)
		@resized = false
	else
		if @loop_bg_counter % 120.0 == 0
			@bg_img = @bg_img1
			@btn = @btn_green
		elsif @loop_bg_counter % 60.0 == 0
			@bg_img = @bg_img2
			@btn = @btn_red
		end
		@loop_bg_counter += 1.0
	
		#ボタンクリックがされたら
		unless @btn_green.is_clicked
			if Input.mousePosX < Window.width.to_i/2 + 100 &&  Input.mousePosX > Window.width.to_i/2 - 100 
				if Input.mousePosY < Window.height.to_i/2 + 60 &&  Input.mousePosY > Window.height.to_i/2 - 60 
					if Input.mousePush?(M_LBUTTON)
						@btn_green.close_btn
						@btn_red.close_btn
						@ship.show
						@enemycon.come
					end
				end
			end
		end
	
		@ship.down_move if Input.keyPush?(K_DOWN)
		@ship.up_move if Input.keyPush?(K_UP)	
	
		Window.draw(-1.5,0,@bg_img)
		@btn.show
		@ship.draw
		@enemycon.show
	end
	Window.drawFont(0, 590, "島根県観光キャラクター「しまねっこ」",@font)
  end
end
end

#url = URI.parse("http://10.0.1.10:3000/scores")#routesのpostの場所から持ってくる
#http = Net::HTTP.new(url.host,url.port)
#p 10000000000000000000000000000000000000000
#p @enemycon
#p 20000000000000000000000000000000000000000

#http.post(url,"utf8=%E2%9C%93&authenticity_token=ZCd4NPO7nIbAAMXXJIwnjPyygWWvV2HQxgXHHTH3X78%3D&score%5Bname%5D=hogi&score%5Bscore%5D="+enemycon.score.to_s+"&commit=Create+Score")
#http.post(url,"utf8=%E2%9C%93&score%5Bname%5D=hogi&score%5Bscore%5D="+@enemycon.score.to_s+"&commit=Create+Score")

