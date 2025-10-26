module Vending_Machine(clk,rst,coin_5,coin_10,sel,candy,cake,cooldrink,change,rtn);

input clk,rst,coin_5,coin_10 ;
input [1:0] sel;

output reg [7:0]rtn;
output reg candy,cake,cooldrink;
output reg change;

reg [7:0]in_money,temp_money;
reg temp;
reg [2:0] state ;//5 STATES
reg[3:0]count;
parameter s0 = 3'd0 ,s1 = 3'd1 ,s2 = 3'd2 ,s3 = 3'd3 ,s4 = 3'd4, s5=3'd5;


always@(rst or coin_5 or coin_10 or temp) begin
if(rst==1)
		in_money=0;
else if(coin_5 & temp==0 & coin_10)
	    in_money= in_money +5+10;
else if(coin_5 & temp==0)
	    in_money= in_money +5;
else if(coin_10 & temp==0)
	    in_money= in_money +10;
else if(temp==1)
		in_money=0;
end

always @(posedge clk or posedge rst)
begin
if(rst==1) begin
		candy=0;
		cooldrink=0;
		cake=0;
		rtn=0;
		change=0;
      state=s0;
		count=0;
		temp_money=0;
		temp=0;
end 
else begin
	case(state)
			s0 : begin
				candy = 0 ;
				cake = 0 ;
				cooldrink = 0;
				change = 0 ;
				rtn=0;
				if(in_money>=8'd5) begin
					  if(count == 10) begin
								temp=1;
								count=0;
								state =s1;
								temp_money =in_money;
							end 
					   else begin
								state =s0;
								count =count +1;
							    temp_money =8'd0;
					   end
				end
				end
	        s1 : begin
 				 temp=0;
				 if(count <= 10) begin
					 count=count+1;
					 case(sel)
				         2'b01 : begin 
				    			 count  =0;
							     if(temp_money >= 5) begin
								 state = s2;
						         end
								 else 
							     state = s5;
				                 end
						2'b10 : begin
				    			 count  =0;
							     if(temp_money >= 10) begin
								 state = s3;
						         end
								 else 
							     state = s5;
				                 
								end
						2'b11 : begin
				    			 count  =0;
							     if(temp_money >= 15) begin
								 state = s4;
						         end
								 else 
							     state = s5;
				                end
						endcase
						end
				else begin
								state  =s0;
								count  =0;
							    rtn    =temp_money; 
				             end
					end

		    s2 : begin
			     candy=1;
				 if(temp_money>5)
						 change=1;
					else 
						change=0;
			     state=s0;
				 end 
		    s3 : begin
			     cake=1;
				 if(temp_money>10)
						 change=1;
					else 
						change=0;
			     state=s0;
				 end 			     
		    s4 : begin
			     cooldrink=1;
				 if(temp_money>15)
						 change=1;
					else 
						change=0;
			     state=s0;
				 end 
			s5: begin
			    state=s0;
				 rtn=temp_money;
             end
	     endcase
    end
	 end
endmodule
