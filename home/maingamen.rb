module Maingamen
  class Director
	require_relative 'home'
	require_relative 'twitter_draw'
    def initialize
			@x_m = 0
			@y_m = 0
  			@x=1.0
			@y=1.0
			@judgment=0
			@resized = false
			@btn1=Button.new(20,520,"スライドパズル",1)
			@btn2=Button.new(220,520,"堀川遊覧船",1)
			@btn3=Button.new(500,300,"twitter to しまね",2)
			@btn4=Button.new(20,560,"ランキング(パズル)",3)
			@btn5=Button.new(650,560,"終了",4)
		  	@btn6=Button.new(220,560,"ランキング(堀川遊覧船)",3)
			@suraido =Suraido.new
			@back =Back.new
			@mozi1 =Mozihyouzi.new(100,20,"Welcome to 島根")
			@mozi2 =Mozihyouzi.new(20,470,"～　ミニゲームコーナー　～")
			@setumei=[]
			@setumei2=[]
			@setumei  << Mozihyouzi.new(200,350,"三瓶山")
			@setumei2 << Mozihyouzi.new(70,380,"三瓶青少年の家やキャンプ場など多くの自然があり、家族、合宿と研修の利用で多くの人が来ておられています")
			@setumei  << Mozihyouzi.new(200,350,"宍道湖")
			@setumei2 << Mozihyouzi.new(70,380,"日本で７番目に大きい湖で、宍道湖７珍が有名である。また夕日が綺麗で夕方には多くの観光者が見に来られます")
			@setumei  << Mozihyouzi.new(140,350,"島根県美術館の庭のうさぎ")
			@setumei2 << Mozihyouzi.new(70,380,"このうさぎに、しじみの殻を置くと幸せを運ぶと言われており写真のようなに多くのしじみが置かれている。")
			@setumei  << Mozihyouzi.new(150,350,"玉湯川の桜並木")
			@setumei2 << Mozihyouzi.new(70,380,"島根で有名な桜の咲く場所です。他にも多くの桜観光名所があり、１番は三刀屋にある全国でも珍しい緑の桜があります。")
			@setumei  << Mozihyouzi.new(160,350,"フォーゲルパーク")
			@setumei2 << Mozihyouzi.new(70,380,"中国地方最大級の花と鳥の楽園であります。ふくろうのショー、ふなの餌やりやペンギン歩く姿などを多くのものを見ることができます。またクリスマスはライトアップをしておりとても綺麗な風景を楽しむこともできます")
			@setumei  << Mozihyouzi.new(190,350,"出雲大社")
			@setumei2 << Mozihyouzi.new(70,380,"６０年に１度の大遷宮が昨年あり,縁結びで有名で神社であります。島根県は１０月を神有月といい、全国各地の神様が出雲大社に集まると言われています。")
			@setumei  << Mozihyouzi.new(180,350,"堀川遊覧船")
			@setumei2 << Mozihyouzi.new(70,380,"松江城の城下町を遊覧船に乗って、一周します。屋根が電動で操作可能であり、橋の高さに応じて変更されることもあります。また冬になると、こたつに入りながら一周できるのでまた違った楽しみ方ができます。")



			@timer = 1
			@st = Array.new
			@st = ["","",""]

    end

    def twitter_get_play
    	@tweet = "aaa"
    	t = Thread.new do
			  @tweet = Array.new
				@t = Twitter_Draw.new
				@ary = @t.tweet_text_get(3)

		    @ary.each do |str|
		      @tweet << str.dup.to_s.scan(/.{1,20}/).join("\n").slice(0..140)
		    end
	    	
	    end
	    @tweet
    end

		def set_timer(sec)
	    @timer = sec * 60
	  end

	  def current_time
	    @timer
	  end

	  def count_down
	    return false unless @timer
	    @timer -= 1
	    @timer
	  end

		def play
			if !@resized
			  Window.resize( 800, 600 )
	  		@resized=true
	  		Window.caption = "メイン画面"
        		end
		 	@back.play
		 	@btn1.play
		 	@btn2.play
			@suraido.play
		 	@mozi1.play
		 	@mozi2.play
			if @suraido.ban == 6 || @suraido.ban == 7
			 @setumei[@suraido.ban-1].setumei
		 	 @setumei2[@suraido.ban-1].setumei
			elsif @suraido.ban == 8
			 @setumei[@suraido.ban-2].setumei
		 	 @setumei2[@suraido.ban-2].setumei
                        else
		 	 @setumei[@suraido.ban].setumei
		 	 @setumei2[@suraido.ban].setumei
			end
		 	@btn3.twitter
			@btn4.play
			@btn5.play
			@btn6.play

			


			unless current_time
				set_timer(5)
			end

			count_down

			if current_time == 0
				@tweet = twitter_get_play
				@timer = false
			end

			@font = Font.new(15)

			damy1 = Image.new(170,140)
			damy2 = Image.new(170,140)
			damy3 = Image.new(170,140)
			

			if @tweet.is_a?(Array)  && !@tweet.empty?
				str = @tweet

				begin
					
					Window.drawFont(450,110,str[0],@font)
	      	@st[0] = str[0]
	      rescue Encoding::UndefinedConversionError
	      	Window.drawFont(450,110,@st[0],@font)
	      end	
				
				begin
					Window.drawFont(450,250,str[1],@font)
					@st[1] = str[1]
				rescue Encoding::UndefinedConversionError
	      	Window.drawFont(450,250,@st[1],@font)
	      end

	      begin
					Window.drawFont(450,390,str[2],@font)
					@st[2] = str[2]
				rescue Encoding::UndefinedConversionError
	      	Window.drawFont(450,390,@st[2],@font)
	      end	
			end

 	#画面移動処理

	 if Input.mouse_push?(M_LBUTTON ) then
	  if @btn1.x_b < Input.mousePosX && @btn1.x_b+180 > Input.mousePosX && @btn1.y_b<Input.mousePosY && @btn1.y_b+30 > Input.mousePosY then
	     @resized = false
	     Scene.set_current_scene(:pazurumain)
	  elsif @btn2.x_b < Input.mousePosX && @btn2.x_b+180 > Input.mousePosX && @btn2.y_b<Input.mousePosY && @btn2.y_b+30 > Input.mousePosY then
	    @resized = false
	    Scene.set_current_scene(:shipmain)
	  elsif @btn4.x_b < Input.mousePosX && @btn4.x_b+180 > Input.mousePosX && @btn4.y_b<Input.mousePosY && @btn4.y_b+30 > Input.mousePosY then
	        @resized = false
		Scene.set_current_scene(:rankinng_pazuru)
		@resized = false
	  elsif @btn6.x_b < Input.mousePosX && @btn6.x_b+180 > Input.mousePosX && @btn6.y_b<Input.mousePosY && @btn6.y_b+30 > Input.mousePosY then
	     @resized = false 
	     Scene.set_current_scene(:rankinng_ship)
	  elsif @btn5.x_b < Input.mousePosX && @btn5.x_b+180 > Input.mousePosX && @btn5.y_b<Input.mousePosY && @btn5.y_b+30 > Input.mousePosY then
	    exit
	  end
	 end

	#島根の移動処理
	if  @judgment == 0 then
	    @x_m = Input.mousePosX 
	    @y_m = Input.mousePosY 
	    @judgment=1
	elsif @x_m != Input.mousePosX && @y_m != Input.mousePosY &&  @judgment == 1 then
	  @x=(Input.mousePosX-@back.x_s).abs
	  @y=(Input.mousePosY-@back.y_s).abs
	  @x_m = Input.mousePosX 
	  @y_m = Input.mousePosY 
	end
	 
	if @x_m <@back.x_s
	    @back.x_s += (-1)*@x/50 
	else
	    @back.x_s += @x/50
	end

	if @y_m<@back.y_s
	   @back.y_s += (-1)*@y/50
	else
	   @back.y_s += @y/50
	end

	@x=@x*0.98
	@y=@y*0.98

	#島根の移動処理　終

	end
end
end

