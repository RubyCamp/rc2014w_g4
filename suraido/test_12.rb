#require 'dxruby'
#require 'uri'
#require 'net/http'
module PazuruMain
class Director
require_relative 'Panel'
	def initialize
	    @resized=false
	    @pazuru =Pazuru.new
	end
	def play
		if !@resized
		Window.resize( 750, 420 )
		@pazuru.panecon.panelshafl
	  	@resized=true
	  	Window.caption = "Pazuru"
		p "hhh"
		@pazuru.panecon.isgoal = false
		end
		@pazuru.play
	end

end
end


class Array
        def swap(n,m)
		if n != 2 && n != 5   
    	            self[n], self[m] = self[m], self[n]
        	end
	end
end

class Pazuru
	@x = Input.mousePosX #?}?E?X?J?[?\???Ix?A?W
	@y = Input.mousePosY #?}?E?X?J?[?\???Iy?A?W
	attr_accessor :panecon
	@images = Image.loadToArray('suraido/images/taisya.png', 3, 3)
	SPACEWID = 90
	SPACEWID1 = 50
	PICWID = @images[0].width
	PICHI = @images[0].height
	def initialize	
	#3*3?I?G?a“u?A?A?￠?e 1???3”z?n
	#‰a‘??dPanel?E?I?・
	@bg_img = Image.load('suraido/images/haikei.jpg')

	@mihon = Image.load("suraido/images/taisya_1.jpg")
	images = Image.loadToArray('suraido/images/taisya.png', 3, 3) 
	panels = []
	images.each do |image|
		panels << Panel.new(false,image)
	end
	panels[panels.size-1].isblank = true
		@panecon = PanelController.new(panels,SPACEWID,SPACEWID1,PICWID,PICHI)	
	end
	@flag = true

	def delay
		f = Thread.new do
			sleep 3
		end
		@flag = false
	end

	def play
		if @panecon.isgoal
		@resized = false
		# url = URI.parse("http://10.0.1.10:3000/score_puzzles")#routes?Ipost?I?e???c?c???A?A?-?e
		url = URI.parse("http://192.168.33.12:3000/score_puzzles")#routes?Ipost?I?e???c?c???A?A?-?e
		http = Net::HTTP.new(url.host,url.port)
		http.set_debug_output($stderr)
		http.post(url,"utf8=%E2%9C%93&score_puzzle%5Bscore%5D="+@panecon.score.to_s+"&commit=Create+Score+puzzle")
		Scene.pazuru_score_set(@panecon.score)
		Scene.set_current_scene(:maingamen)
		else
			@x = Input.mousePosX #?}?E?X?J?[?\???Ix?A?W
			@y = Input.mousePosY #?}?E?X?J?[?\???Iy?A?W
			Window.drawScale(0, 0, @bg_img, 1.55, 1.7, 0, 0)
			if 8 <= @x && 193 >= @x && 7 <= @y && 131 >= @y && Input.mousePush?(M_LBUTTON)
     				@panecon.exchange(1,1)
			end

	     		if 202 <= @x && 387 >= @x && 7 <= @y && 131 >= @y && Input.mousePush?(M_LBUTTON)
     				@panecon.exchange(2,1)
     			end

     			if 396 <= @x && 580 >= @x && 7 <= @y && 131 >= @y && Input.mousePush?(M_LBUTTON)
     				@panecon.exchange(3,1)
     			end

		     	if 8 <= @x && 193 >= @x && 139 <= @y && 263 >= @y && Input.mousePush?(M_LBUTTON)
		     		@panecon.exchange(1,2)
     			end

		     	if 202 <= @x && 387 >= @x && 139 <= @y && 263 >= @y  && Input.mousePush?(M_LBUTTON)
		     		@panecon.exchange(2,2)
		     	end

		     	if 396 <= @x && 580 >= @x && 139 <= @y && 263 >= @y  && Input.mousePush?(M_LBUTTON)
		     		@panecon.exchange(3,2)
		    	end

			if 8 <= @x && 193 >= @x && 270 <= @y && 394 >= @y && Input.mousePush?(M_LBUTTON)
	     			@panecon.exchange(1,3)
	    	 	end

			if 202 <= @x && 387 >= @x && 270 <= @y && 394 >= @y &&Input.mousePush?(M_LBUTTON)
	  			@panecon.exchange(2,3)
     			end

			if 396 <= @x && 580 >= @x && 270 <= @y && 394 >= @y && Input.mousePush?(M_LBUTTON)
				@panecon.exchange(3,3)
			end

			@panecon.alldraw
			Window.draw(Window.width / SPACEWID * 4 + PICWID * 3, Window.height / SPACEWID1, @mihon) #?@?c?{?d?`‰a?・?e
  		end
		end
end