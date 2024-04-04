module apb #(parameter addrWidth = 12 )(
	input pclk,
	input presetn,
	input psel,
	input penable,
	input pwrite,
	input [addrWidth-1:0] paddr,
	input [31:0] pwdata,
	output reg pready,
	output reg [31:0] prdata
);

typedef enum bit [1:0] {IDLE, SETUP,ACCESS} apb_states;

reg [31:0] mem [(2**12)-1:0]; //strob not implemented 


apb_states p_state, n_state;
integer i;
always @(posedge pclk or negedge presetn) begin
	if (~presetn) begin
		p_state <= IDLE;
		for (i = 0; i< 2**12;i++) begin
			mem[i] <= 32'b0;
		end
	end
	else begin
		p_state <= n_state;
		if (pwrite) begin
			mem[paddr] <= pwdata;
		end
	end
end

always_comb begin
	pready = 1'b0;
	prdata = 32'b0;
	case (p_state) 
		IDLE: begin
			if (~psel && ~penable) begin
				n_state = IDLE;
			end
			else if (psel && ~penable) begin
				n_state = SETUP;
			end
		end
		SETUP: begin //it should always remain 1 cycle here -> should i remove the condition
			if (psel && penable ) begin 
				n_state = ACCESS;
			end
			else begin 
				n_state = SETUP;
			end
		end
		ACCESS: begin
			if(psel &&~penable) begin
				n_state = SETUP;
				pready = 1'b1;
				if (~pwrite) begin
					prdata = mem[paddr];
				end
			end
			else if (~psel && ~penable) begin
				n_state = IDLE;
				pready  = 1'b1;
				if (~pwrite) begin
					prdata = mem[paddr];
				end
			end
			else if (psel && penable) begin
				n_state = ACCESS;
				pready = 1'b0;
			end
		end
		default : begin
			n_state =IDLE;
			pready = 1'b0;
		end
	endcase
end

endmodule : apb
