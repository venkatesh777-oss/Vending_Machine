module tb;

	// Inputs
	reg clk;
	reg rst;
	reg coin_5;
	reg coin_10;
	reg [1:0] sel;

	// Outputs
	wire candy;
	wire cake;
	wire cooldrink;
	wire change;
	wire [7:0] rtn;

	// Instantiate the Unit Under Test (UUT)
	VM uut (
		.clk(clk), 
		.rst(rst), 
		.coin_5(coin_5), 
		.coin_10(coin_10), 
		.sel(sel), 
		.candy(candy), 
		.cake(cake), 
		.cooldrink(cooldrink), 
		.change(change), 
		.rtn(rtn)
	);

   // Task: simulate inserting coins and selecting item
task item(input [1:0] sel1, input integer n5, input integer n10); 
   integer i;
   begin
      // Insert 5rs coins n5 times
      for(i=0; i<n5; i=i+1) begin
         coin_5 = 1;
         #10;
         coin_5 = 0;
         #10;
      end
      
      // Insert 10rs coins n10 times
      for(i=0; i<n10; i=i+1) begin
         coin_10 = 1;
         #10;
         coin_10 = 0;
         #10;
      end

      // Now select the item
      sel = sel1;
      #20;
      sel = 0;
   end
endtask

	initial begin
		// Initialize Inputs
		clk = 0;
		forever #2 clk=~clk;
   end

   initial begin	 
		rst = 1;
		coin_5 = 0;
		coin_10 = 0;
		sel = 0;
      #4;
		rst = 0;

      item(1,1,0); // sel candy ₹5
      #10;
      item(1,0,1); // candy ₹10 (extra coin, expect change)
      #10;
      item(2,0,1); // sel cake ₹10
      #10;
      item(2,1,1); // sel cake ₹15 (5+10)
      #10;
      item(3,1,1); // sel cooldrink ₹15 (5+10)
      #10;
      item(3,1,0); // insert ₹5 first
      #10;
      item(3,0,2); // then ₹10 (total ₹15)
      #10;
      item(3,0,1); // insert 2×₹10 = ₹20
      #50;
      
      $finish;		
	end
endmodule
