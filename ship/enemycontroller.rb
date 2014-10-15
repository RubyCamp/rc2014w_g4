class EnemyController
	attr_accessor :timer,:score,:is_clicked 
	attr_reader :created_enemys
	def initialize(ship)
		@enemys = ["ship/images/sijimi.png","ship/images/ebi.png",
							 "ship/images/unagi.png","ship/images/shimane.png"]
		@scores = [10,20,15,35]
		@score = 0
		@timer = 2000
		@created_enemys = []
		@is_clicked = false
		@blank_count = 0
		@ship = ship
	end
	
	def come
		@is_clicked = true
	end
	
	def show
		#puts @blank_count
		if @blank_count == 0 && @is_clicked
			enemy = create_enemy
		end
		
		self.move_enemy
		
		if @blank_count < 60
			@blank_count += 1
		else
			@blank_count = 0
		end
	end
	
	def create_enemy
		ene_index = rand(4)
		enemy = Enemy.new(@enemys[ene_index],125 + rand(300),@scores[ene_index])
		@created_enemys << enemy
		return enemy
	end
	
	def move_enemy
		if @is_clicked
			font = Font.new(32)
			Window.drawFont(Window.width-200,10, "SCORE : " + @score.to_s , font)
			Window.drawFont(0,10, "Time : " + @timer.to_s , font)
			@timer -= 1
			removes = []
			remove_index = 0
			@created_enemys.each do |enemy|
				enemy.x += 10
				enemy.draw
				removes << remove_index if enemy.x > Window.width
				remove_index += 15
			end
			
			@created_enemys.each do |enemy|
				@ship.check(enemy).each do |hit|
				@score += enemy.score if enemy.atack
				end
				#Sprite.check(@ship.image,enemy.image)
			end

			removes.each do |reindex|
				@created_enemys.delete_at(reindex.to_i)
			end
			
		end
	end
end
