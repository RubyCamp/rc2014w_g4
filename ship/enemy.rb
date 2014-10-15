class Enemy < Sprite

	attr_reader :score
	def initialize(image,y,score)
		self.image = Image.load(image)
		self.x = 0
		self.y = y
		self.z = 0
		@score = score
	end
	
	def play
		self.draw if self.x > Window.width
	end
	
	def atack
		self.x = Window.width
		return true
	end

end