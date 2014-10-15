class Button1
  	attr_accessor :btn,:x_b,:y_b,:is_clicked
	def initialize(x,y,fileinfo) 
	  @btn= Image.load(fileinfo)
	  @x_b=x
	  @y_b=y
	  @is_cliked = false
	end

	def show
		Window.draw_scale(@x_b,@y_b,@btn,4,4,nil,nil,0) unless @is_cliked
	end
	
	def close_btn
		@is_cliked = true
	end
end