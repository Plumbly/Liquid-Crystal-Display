class LCD
       attr_accessor( :size, :spacing )

       #
       # This hash is used to define the segment display for the
       # given digit. Each entry in the array is associated with
       # the following states:
       #
       #    HORIZONTAL
       #    VERTICAL
       #    HORIZONTAL
       #    VERTICAL
       #    HORIZONTAL
       #    DONE
       #
       # The HORIZONTAL state produces a single horizontal line. There
       # are two types:
       #
       #    0 - skip, no line necessary, just space fill
       #    1 - line required of given size
       #
       # The VERTICAL state produces a either a single right side line,
       # a single left side line or a both lines.
       #
       #    0 - skip, no line necessary, just space fill
       #    1 - single right side line
       #    2 - single left side line
       #    3 - both lines
       #
       # The DONE state terminates the state machine. This is not needed
       # as part of the data array.
       #
       @@lcdDisplayData = {
	    "0" => [ 1, 3, 0, 3, 1 ],
	    "1" => [ 0, 1, 0, 1, 0 ],
	    "2" => [ 1, 1, 1, 2, 1 ],
	    "3" => [ 1, 1, 1, 1, 1 ],
	    "4" => [ 0, 3, 1, 1, 0 ],
	    "5" => [ 1, 2, 1, 1, 1 ],
	    "6" => [ 1, 2, 1, 3, 1 ],
	    "7" => [ 1, 1, 0, 1, 0 ],
	    "8" => [ 1, 3, 1, 3, 1 ],
	    "9" => [ 1, 3, 1, 1, 1 ],
	    "A" => [ 1, 3, 1, 3, 0 ],
	    "B" => [ 1, 3, 2, 3, 1 ],
	    "C" => [ 1, 2, 0, 2, 1 ],
	    "D" => [ 0, 1, 1, 3, 1 ],
	    "E" => [ 1, 2, 1, 2, 1 ],
	    "F" => [ 1, 2, 1, 2, 0 ],
       }

       @@lcdStates = [
           "HORIZONTAL",
           "VERTICAL",
           "HORIZONTAL",
           "VERTICAL",
           "HORIZONTAL",
           "DONE"
       ]

       def initialize( size, spacing )
           @size = size
           @spacing = spacing
       end

       def display(characters)
	      states = @@lcdStates  
	      for index in 0...states.length
		     pos = states[index]
		     line = ""
		     case pos
		     when "HORIZONTAL"				       
			    characters.each_byte do |a|			    
				   line += horizontal_line(@@lcdDisplayData[a.chr][index])
			    end		     
		     when "VERTICAL"
			    characters.each_byte do |b|
				   line += vertical_line(@@lcdDisplayData[b.chr][index])					  
			    end				   				   		     
		     end
		     print line + "\n"		     		    
	      end	
       end 
             
       def horizontal_line(position)
	   case position
	   when 1	  
	      line = " " + ("-" * @size) + " " + (" " * @spacing)
	   when 0
	      line = " " + (" " * @size) + " " + (" " * @spacing)
	   end
	   return line
       end
	   
       def vertical_line(position)
           case position
	   when 1	  
	      line = " " + (" " * @size) + "|" + (" " * @spacing)
	   when 2
	      line = "|" + (" " * @size) + " " + (" " * @spacing)
           when 3
	      line = "|" + (" " * @size) + "|" + (" " * @spacing)
           when 0
	      line = " " + (" " * @size) + " " + (" " * @spacing)
           end
           return line
       end       
end
    d = LCD.new(2, 1)
    d.display("0123456789ACDEF") 