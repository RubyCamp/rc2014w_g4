#require 'dxruby'

class Button
  	attr_accessor :btn,:x_b,:y_b,:mozi

	def initialize(x,y,mozi,ban)
	  @btn= Image.load("./images//#{ban}.png")
	  @x_b=x
	  @y_b=y
	  @mozi=mozi
	  @ban=ban
	  @font1 = Font.new(32)
	  @font2 = Font.new(16)
	end

	def play
	  #if @ban != 4
	  Window.draw( @x_b, @y_b, @btn )
	  #else
	  #Window.draw_scale( @x_b-50, @y_b,@btn, 0.4 ,1, centerx=nil, centery=nil, z=0 )
          #end

	  Window.drawFont(@x_b+10, @y_b+10, self.mozi, @font2) 
	end


	def twitter
	  Window.draw_scale( @x_b, @y_b,@btn, 1.7 ,15, centerx=nil, centery=nil, z=0 )
	  #Window.draw( @x_b, @y_b, @btn )
	  
	  Window.drawFont(@x_b-50, @y_b-265, mozi, @font1) 
	end
end

class Mozihyouzi
	attr_accessor :x_b,:y_b,:mozi
	def initialize(x,y,mozi) 
	  @x_b=x
	  @y_b=y
	  @mozi=mozi.scan(/.{1,20}/).join("\n")
	  @font1 = Font.new(32)
	  @font2 = Font.new(16)
	end

	def play
	  Window.drawFont(@x_b+10, @y_b+10, @mozi, @font1) 
	end

	def setumei
	  Window.drawFont(@x_b, @y_b, @mozi, @font2) 
	end
end

class Suraido
  attr_accessor :ban #画像の順番
  attr_accessor :count#画像の表示時間

   	def initialize()
	  @zazous= [] 
	  (1..9).each do |i|
  	     @zazous << Image.load("./images/bo-nasu/#{i}.png")
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
	  Window.draw(20, 90,@zazous[@ban] )
        end
end


class Back
attr_accessor :background,:x_s,:y_s #背景の島根画像
	def initialize
	  @background= Image.load("./images/shimane.png")
	  @x_s=150
	  @y_s=200
	end

       def play
	   Window.draw_scale( @x_s-130, @y_s-170, background, 0.6 ,0.6, centerx=nil, centery=nil, z=0 )
	   #Window.draw(0, 0,background)
	end
end
   