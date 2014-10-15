require 'dxruby'

class Button
  	attr_accessor :btn,:x_b,:y_b,:mozi

	def initialize(x,y,mozi) 
	  @btn= Image.load("1.png")
	  @x_b=x
	  @y_b=y
	  @mozi=mozi

	end

	def play
	  Window.draw( @x_b, @y_b, @btn )
	  font = Font.new(16)
	  Window.drawFont(@x_b+10, @y_b+10, mozi, font) 
	end
end

class Mozihyouzi
	attr_accessor :x_b,:y_b,:mozi
	def initialize(x,y,mozi) 
	  @x_b=x
	  @y_b=y
	  @mozi=mozi

	end

	def play
	  font = Font.new(32)
	  Window.drawFont(@x_b+10, @y_b+10, @mozi, font) 
	end

	def setumei
	  font = Font.new(16)
	  Window.drawFont(@x_b+10, @y_b+10, @mozi, font) 
	end
end

class Suraido
  attr_accessor :ban #画像の順番
  attr_accessor :count#画像の表示時間

   	def initialize()
	  @zazous= [] 
	  (1..9).each do |i|
  	     @zazous << Image.load("bo-nasu/#{i}.png")
	  end
          @count=2*60
	  @ban=0
	end

	def play
           @count -= 1
	   if @count <= 0 
	     @count=2*60
	     @ban+=1
	   end 
	  if @ban>8
	    @ban=0
	  end
	  Window.draw(20, 100,@zazous[@ban] )
        end
end


class Back
attr_accessor :background,:x_s,:y_s #背景の島根画像
	def initialize
	  @background= Image.load("shimane.png")
	  @x_s=150
	  @y_s=200
	end

       def play
	   Window.draw_scale( @x_s-130, @y_s-170, background, 0.4 ,0.4, centerx=nil, centery=nil, z=0 )
	   #Window.draw(0, 0,background)
	end
end
   