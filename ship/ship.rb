class Ship < Sprite
	attr_accessor :isshow
	def initialize
		self.x = 550
		self.y = 350
		self.image = Image.load("ship/images/ship.png")
		self.z = 0
		@isshow = false
	end
	
	def play
		puts "sss"
		self.draw if @isshow
	end
	
	def show
		@isshow = true
	end
	
	def up_move
		self.y -= 10
	end
	
	def down_move
		self.y += 10
	end

	def hit(obj)
		puts "hit"
	end
	
	def shot(obj)
		puts "shot"
	end
	
	def update
		puts "upppp"
	end
end