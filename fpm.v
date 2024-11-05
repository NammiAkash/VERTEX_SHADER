`timescale 1ns/ 1ps

module test (clk,a0,b0,r0);
input [15:0] a0,b0;
input clk;
output reg [15:0] r0;
reg [15:0] a,b;
wire [15:0] result;
fpm f1(a,b,result);
always @(posedge clk) begin
a<= a0;
b<= b0;
r0<= result;
end 
endmodule

module fpm (
	input wire [15:0] a, 
	input wire [15:0] b,
	output reg [15:0] result);

//	reg sign_a;
//	reg sign_b;

//	reg [4:0] exp_a;
//	reg [4:0] exp_b;

//	reg [10:0] mant_a;
//	reg [10:0] mant_b;

	reg sign_result;

	reg [5:0] exp_sum ;
//	reg [4:0] incremented_exp;
	reg [5:0] incremented_exp;
//	reg [4:0] exp_result;

	reg [21:0] mant_product;
	reg [21:0] shifter_result;  
    	reg [10:0] rounding;
    	reg [10:0] truncated;
    	reg R;
	reg S;
   	reg [10:0] incremented_value;
	reg [4:0] norm_exp;


	always @(*) begin

//	sign_result = sign_a ^ sign_b;
	sign_result =a[15] ^ b[15] ;

	end

	always @(*) begin
//		exp_sum = {1'b0, exp_a} + {1'b0, exp_b} -15;
		exp_sum = {1'b0, a[14:10]} + {1'b0, b[14:10]}- 15;

//		exp_result = exp_sum[4:0];

//		incremented_exp = exp_result +1;
		incremented_exp = exp_sum + 1;

	end
 
	always @(*) begin

		if (a==16'h0 || b==16'h0) begin 
			result =16'h0;
		end else begin 
//		sign_a = a[15];
//		sign_b = b[15];
//		exp_a = a[14:10];
//		exp_b = b[14:10];
//		mant_a = {1'b1, a[9:0]};
//		mant_b = {1'b1, b[9:0]};

		//sign_result = sign_a ^ sign_b;

		//exp_sum = {1'b0, exp_a} + {1'b0, exp_b} -15;

		//exp_result = exp_sum[4:0];

		mant_product = {1'b1, a[9:0]} * {1'b1, b[9:0]};	

		if( mant_product[21] == 1'b0) begin
			shifter_result = {mant_product[20:0],1'b0};
			//norm_exp = exp_result;
			norm_exp = exp_sum[4:0];
		end else begin
			shifter_result = mant_product;
			norm_exp = incremented_exp[4:0];
		end

		truncated = shifter_result[21:11];	
		R = shifter_result[10];
		incremented_value = truncated + 1;
		S = |shifter_result[9:0];
		rounding = R ? (S ? incremented_value: (truncated[0] ? incremented_value : truncated)):truncated;
		result = {sign_result, norm_exp,rounding[9:0]};
	end
	end
endmodule 

