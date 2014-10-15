
#require 'dxruby'
#require 'uri'
#require 'net/http'
class Array
 def swap(n,m)
		  if n != 2 && n != 5   
		      self[n], self[m] = self[m], self[n]
		   end
		  end
end


module PazuruMain
SPACEWID = 90
SPACEWID1 = 50
PICWID = 0
PICHI = 0

class Director
		
	require_relative 'Panel'
		def initialize
			@resized=false
		    @bg_img = Image.load('suraido/images/haikei.jpg')
		    @mihon = Image.load("suraido/images/taisya_1.jpg")
  		    @images = Image.loadToArray('suraido/images/taisya.png', 3, 3) #3*3の絵が入っている 1次元配列
		    @panels = []
		    @images.each do |image|
		    @panels << Panel.new(false,image)
		    end

		    @panels[@panels.size-1].isblank = true
				
		    @panels.each do |panel|
		    
		    end
		    
		    @panecon =PanelController.new(@panels,SPACEWID,SPACEWID1,PICWID,PICHI)
		end
		

		def play
			if !@resized
	  		Window.resize( 750, 420 )
	  		@resized=true
	  		Window.caption = "メイン画面"
        		end
			if @panecon.isgoal
			url = URI.parse("http://10.0.1.10:3000/score_puzzles")#routesのpostの場所から持ってくる
			http = Net::HTTP.new(url.host,url.port)
			http.set_debug_output($stderr)
			http.post(url,"utf8=%E2%9C%93&score_puzzle%5Bscore%5D="+panecon.score.to_s+"&commit=Create+Score+puzzle")
			@resized = false
			Scene.set_current_scene(:maingamen)
			else
				x = Input.mousePosX #マウスカーソルのx座標
				y = Input.mousePosY #マウスカーソルのy座標
				Window.drawScale(0, 0,@bg_img, 1.55, 1.7, 0, 0)
				if 8 <= x && 193 >= x && 7 <= y && 131 >= y && Input.mousePush?(M_LBUTTON)
	     				@panecon.exchange(1,1)
				end

		     		if 202 <= x && 387 >= x && 7 <= y && 131 >= y && Input.mousePush?(M_LBUTTON)
	     				@panecon.exchange(2,1)
	     			end

	     			if 396 <= x && 580 >= x && 7 <= y && 131 >= y && Input.mousePush?(M_LBUTTON)
	     				@panecon.exchange(3,1)
	     			end

			     	if 8 <= x && 193 >= x && 139 <= y && 263 >= y && Input.mousePush?(M_LBUTTON)
			     		@panecon.exchange(1,2)
	     			end

			     	if 202 <= x && 387 >= x && 139 <= y && 263 >= y  && Input.mousePush?(M_LBUTTON)
			     		@panecon.exchange(2,2)
			     	end

			     	if 396 <= x && 580 >= x && 139 <= y && 263 >= y  && Input.mousePush?(M_LBUTTON)
			     		@panecon.exchange(3,2)
			    	end

				if 8 <= x && 193 >= x && 270 <= y && 394 >= y && Input.mousePush?(M_LBUTTON)
		     			@panecon.exchange(1,3)
		    	 	end

				if 202 <= x && 387 >= x && 270 <= y && 394 >= y &&Input.mousePush?(M_LBUTTON)
		  			@panecon.exchange(2,3)
	     			end

				if 396 <= x && 580 >= x && 270 <= y && 394 >= y && Input.mousePush?(M_LBUTTON)
					@panecon.exchange(3,3)
				end

				@panecon.alldraw
				Window.draw(Window.width / SPACEWID * 4 + PICWID * 3, Window.height / SPACEWID1, mihon) #　見本を描画する
	  		end
			
		end
	
end
end
