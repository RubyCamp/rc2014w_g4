
module Ranking_Ship
  class Director
   	def initialize
       @resized=false
	@font = Font.new(32)
   	end

   	def install
       	@rank = getJson
		@my_score = Scene.ship_score
	end

	def getJson
		html = open("http://10.0.1.10:3000/score_ships").read
		#html = open("http://192.168.33.12:3000/score_ships").read
		parsed_json = JSON.parser.new(html)
		result = parsed_json.parse.map { |h|
		  h['score']
		}.sort.reverse
	end

    def play
		install
		if !@resized
		  Window.resize( 800, 600 )
		  @resized=true
		  Window.caption = "ランキング"
        end
	
		
		Window.drawFont(300, 10, "ランキング", @font)
	
		#font = Font.new(16)
		10.times do |i|
			Window.drawFont(280, 100+30*i, (i+1).to_s+"位", @font)
			if @my_score != @rank[i]
				Window.drawFont(350, 100+30*i, @rank[i].to_s, @font)
			elsif
				Window.drawFont(350, 100+30*i, @rank[i].to_s, @font,color:[255,0,0])
			end
		end
		Window.drawFont(450, 350, "my_score", @font)
		Window.drawFont(475, 400, @my_score.to_s, @font)

		if Input.mouse_push?(M_LBUTTON ) then
			@resized=false
			Scene.set_current_scene(:maingamen)
		end
	end
	end
end