import uvm_pkg::*;
`include "uvm_macros.svh"

module hdl_top();

apb_interface #(.addrWidth(12)) apb_if();


always #50 apb_if.pclk = ~apb_if.pclk;


apb #(.addrWidth(12)) DUT (
	.pclk(apb_if.pclk),
	.presetn(apb_if.presetn),
	.psel(apb_if.psel),
	.penable(apb_if.penable),
	.pwrite(apb_if.pwrite),
	.paddr(apb_if.paddr),
	.pwdata(apb_if.pwdata),
	.pready(apb_if.pready),
	.prdata(apb_if.prdata)
);

bind DUT assertions #(.addrWidth(12))
assertion_inst ( 
	.pclk(apb_if.pclk),
	.presetn(apb_if.presetn),
	.psel(apb_if.psel),
	.penable(apb_if.penable),
	.pwrite(apb_if.pwrite),
	.paddr(apb_if.paddr),
	.pwdata(apb_if.pwdata),
	.pready(apb_if.pready),
	.prdata(apb_if.prdata)
);

initial begin
	apb_if.pclk <= 1'b0;
	uvm_config_db #(virtual apb_interface)::set(null,"uvm_test_top","apb_interface",apb_if);
end

endmodule :hdl_top
