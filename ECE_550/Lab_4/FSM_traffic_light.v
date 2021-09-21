module FSM_traffic_light(walk,clock,light);
	input clock;
	input walk;
	reg[2:0] state_C;
	reg[2:0] state_N;
	reg in;
	reg[4:0] out;
	output[4:0] light;

	parameter S1=3'b001;
	parameter out1=5'b00110;
	parameter S2=3'b010;
	parameter out2=5'b01001;
	parameter S3=3'b101;
	parameter out3=5'b10000;
	parameter S4=3'b110;
	parameter out4=5'b10000;
	
	initial begin 
		state_C= S2;
	end
	
	always @(posedge clock) begin
		if (state_C==S1 && in==1) begin 
			state_N=S3;
			out<=out3;
		end
		else if (state_C==S1 && in==0) begin
			state_N=S2;
			out<=out2;
		end
		else if (state_C==S2 && in==0) begin 
			state_N=S1;
			out<=out1;
		end
		else if (state_C==S2 && in==1) begin 
			 state_N=S4;
			 out<=out4;
		end
		else if (state_C==S3) begin 
			 state_N=S2;
			 out<=out2;
		end
		else if (state_C==S4) begin
			 state_N=S1; 
			 out<=out1;
		end
		state_C=state_N;
	end
	always @(posedge walk) begin
		in <= walk;
	end 
	assign light= out;
endmodule 
