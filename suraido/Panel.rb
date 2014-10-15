require 'pp'
class Panel
	attr_accessor :isblank, :image
	attr_reader :panecon
	def initialize(isblank,image)
		@isblank = isblank
		@image = image
	end

	def print
		puts "isblank is " + @isblank.to_s
		puts "image is " + @image.to_s

	end
end

class DamyPanel < Panel
	def initialize
		@isblank = false
		@image = -1
	end
end


class PanelController
	attr_accessor :panelss, :anspanelss, :isgoal,:score
	SPACEWID = 0
 	SPACEWID1=0
	PICWID=0
	PICHI=0
	def initialize(panels,spacewid,spacewid1,picwid,pichi)
		@score = 10000
		@isgoal = false
		@notfirst = false
		@spacewid = spacewid
		@spacewid1 = spacewid1
		@picwid = picwid
		@pichi = pichi
		@font = Font.new(32)
		@anspanelss = [[DamyPanel.new] * 5]
		@panelss = [[DamyPanel.new] * 5]
			count = 0
			3.times do
				tempa = []#Array.new
				tempa << DamyPanel.new
				temp = []#Array.new
				temp << DamyPanel.new
				counttemp = count
				3.times do
					
					tempa << panels[counttemp]
					temp << panels[counttemp]
					counttemp += 3
				end
				tempa << DamyPanel.new
				temp << DamyPanel.new
				@anspanelss << tempa
				@panelss << temp
				count += 1
		end

		@anspanelss << [DamyPanel.new] * 5
		@panelss << [DamyPanel.new] * 5
		
		puts @panelss
		def panelshafl
			10000.times do
				seedx = rand(3)+1
				seedy = rand(3)+1
				exchange(seedx,seedy)
			end
		@score = 1000
		end
	end

	def alldraw
		Window.draw(Window.width / @spacewid, Window.height / @spacewid1,@panelss[1][1].image)unless @panelss[1][1].isblank
		Window.draw(Window.width / @spacewid * 2 + @picwid, Window.height / @spacewid1 ,@panelss[2][1].image)unless @panelss[2][1].isblank
		Window.draw(Window.width / @spacewid * 3 + @picwid * 2, Window.height / @spacewid1,@panelss[3][1].image)unless @panelss[3][1].isblank
		Window.draw(Window.width / @spacewid, Window.height / @spacewid1 * 2 + @pichi,@panelss[1][2].image)unless @panelss[1][2].isblank
		Window.draw(Window.width / @spacewid * 2 + @picwid, Window.height / @spacewid1 * 2 + @pichi,@panelss[2][2].image)unless @panelss[2][2].isblank
		Window.draw(Window.width / @spacewid * 3 + @picwid * 2, Window.height / @spacewid1 * 2 + @pichi,@panelss[3][2].image)unless @panelss[3][2].isblank
		Window.draw(Window.width / @spacewid, Window.height / @spacewid1 * 3 + @pichi * 2, @panelss[1][3].image)unless @panelss[1][3].isblank
		Window.draw(Window.width / @spacewid * 2 + @picwid, Window.height / @spacewid1 * 3 + @pichi * 2,  @panelss[2][3].image)unless @panelss[2][3].isblank
		Window.draw(Window.width / @spacewid * 3 + @picwid * 2, Window.height / @spacewid1 * 3 + @pichi * 2, @panelss[3][3].image)unless @panelss[3][3].isblank
		Window.drawFont(Window.width-120,300, "SCORE\n  " + @score.to_s , @font)
	end


	#パネルの中を探索して，
	def serch(srpanel)
		rowindex = 0
		hitplace = ""
		@panelss.each do |panels|
			colindex = 0
			panels.each do |panel|
				if panel.isblank == srpanel.isblank && panel.image == srpanel.image
					hitplace = rowindex.to_s + "/" + colindex.to_s
				else
					colindex += 1
				end
			end
			rowindex += 1
		end
		hitplace
	end

	def exchange(rowindex,colindex)
		unless @panelss[rowindex][colindex].isblank
			if rowindex == 1
				exchange_row_under(rowindex,colindex)
				elsif rowindex == 2
					if exchange_row_under(rowindex,colindex) > 0
					else	
						exchange_row_upper(rowindex,colindex)
				end
				elsif rowindex == 3
					exchange_row_upper(rowindex,colindex)
			end
			if colindex == 1
				exchange_col_under(rowindex,colindex)
				elsif colindex == 3
					exchange_col_upper(rowindex,colindex)
				else
					if exchange_col_under(rowindex,colindex) > 0
					else	
						exchange_col_upper(rowindex,colindex)
					end
				
			end
		end
		@isgoal = goalcheck
	end

	def goalcheck
		@anspanelss.each_with_index do |panels,row|
			panels.each_with_index do |panel,col|
				unless @panelss[row][col].image == @anspanelss[row][col].image
					return false
				end
			end
		end
		return true
	end
	
	def exchange_row_under(rowindex,colindex)
		if @panelss[rowindex+1][colindex].isblank
			change_panel(rowindex,colindex,rowindex+1,colindex)
			return 1
		else
			return -1
		end
	end

	def exchange_row_upper(rowindex,colindex)
		
		if @panelss[rowindex-1][colindex].isblank
			change_panel(rowindex,colindex,rowindex-1,colindex)
			return 1
		else
			return -1
		end
	end


	def exchange_col_under(rowindex,colindex)
		
		if @panelss[rowindex][colindex+1].isblank
			change_panel(rowindex,colindex,rowindex,colindex+1)
			return 1
		else
			return -1
		end
	end

	def exchange_col_upper(rowindex,colindex)
		
		if @panelss[rowindex][colindex-1].isblank
			change_panel(rowindex,colindex,rowindex,colindex-1)
			return 1
		else
			return -1
		end
	end

	def change_panel(rowindex1,colindex1,rowindex2,colindex2)
		@score -= 1
		temp = @panelss[rowindex1][colindex1]
		@panelss[rowindex1][colindex1] = @panelss[rowindex2][colindex2]
		@panelss[rowindex2][colindex2] = temp
	end

	def print
		puts "======panelss======="
		@panelss.each do |panels|
			panels.each do |panel| 
				puts panel.image
			end
		puts ""
		end
		
		puts "======anspanelss======="
		@anspanelss.each do |panels|
			panels.each do |panel| 
				puts panel.image
			end
		puts ""
		end
		
	end

end
