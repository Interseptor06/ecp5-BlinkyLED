module blink (
    input      clk_i,
    output reg led_o
);
// LED will blink at Clock Speed/MAX per second
localparam MAX = 5_000_000;

// Returns the number of bits nessecary to hold MAX
// In the case of 12_500_000 that is 24
localparam WIDTH = $clog2(MAX);

wire clk_s;

assign clk_s = clk_i;


// 24 bit register
reg  [WIDTH-1:0] cpt_s;
wire [WIDTH-1:0] cpt_next_s = cpt_s + 1'b1;

reg toggle = 1'b0;

// This is to check if the counter is at it's end and a signal to reset it
wire end_s = (cpt_s == MAX-1);


always @(posedge clk_s) begin
	//{WIDTH{1'b0}} is a vector with length WIDTH full of zeroes -> Reset
	//(rst_s || end_s) this checks whether a reset is generated OR the counter is at its end
	if(end_s) begin
		cpt_s = {WIDTH{1'b0}};
		toggle = ~toggle;
		end
	else begin
		cpt_s = cpt_next_s;
		end
    //cpt_s <= (rst_s || end_s) ? {WIDTH{1'b0}} : cpt_next_s;

	if (toggle)
        led_o <= 1'b0;
		
    else
        led_o <= ~led_o;

end
endmodule
