module rst_gen (
	input 			clk_i,
	input 			rst_i,
	output			rst_o
);

/* try to generate a reset */

// 3 bit vector of type reg
reg [2:0]	rst_cpt;
always @(posedge clk_i) begin
	if (rst_i)
		// 3'b0 is the same as 000
		rst_cpt = 3'b0;
	else begin
		if (rst_cpt == 3'b100)
				rst_cpt = rst_cpt;
			
		else
			// Increments by one
			rst_cpt = rst_cpt + 3'b1;
	end
end

// If rst_cpt is 010 then !rst_cpt[2] equals 0 because !1 = 0
assign rst_o = !rst_cpt[2];

endmodule
