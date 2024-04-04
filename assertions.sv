import uvm_pkg::*;
`include"uvm_macros.svh"

module assertions #(parameter addrWidth =12)( // (apb_interface apb_if);
	input pclk,presetn,psel,pwrite,pready, penable,
	input [31:0] prdata,pwdata,
	input [addrWidth-1:0] paddr
);
//property read_seq;
 //@(posedge pclk) disable iff (~apb_if.presetn)
 //	(apb_if.psel && ~apb_if.pwrite && $stable(apb_if.paddr) ) throughout 
//endproperty 

property paddr_valid;
	@(posedge  pclk) disable iff (~presetn)
	psel |-> (!$isunknown(paddr) and $stable(paddr));
endproperty

PADDR_VALID : assert property (paddr_valid) else `uvm_error("ASSERT","addr is not stable when psel is high")

property pwrite_valid;
	@(posedge pclk) disable iff (~presetn)
	psel |-> (!$isunknown(pwrite) and $stable(pwrite));
endproperty

PWRITE_VALID : assert property (pwrite_valid) else `uvm_error("ASSERT","pwrite is not valid when psel is high")

property pwdata_valid;
	@(posedge pclk) disable iff (~presetn) //same cycle ? 
	(pwrite and psel) |-> ($stable(pwdata) and !$isunknown(pwdata) and $stable(paddr));
endproperty

PWDATA_VALID : assert property (pwdata_valid) else `uvm_error("ASSERT","pwdata/paddr is not valid when pwrite is high")

property prdata_valid;
	@(posedge pclk) disable iff (~presetn)
	pready |-> ($stable(prdata) and !$isunknown(prdata));
endproperty

PRDATA_VALID : assert property (prdata_valid) else `uvm_error("ASSERT","prdata is not valid when pready is high")

property penable_pready;
	@(posedge pclk) disable iff (~presetn)
	(pready && penable) |=> (~pready) && ~(penable);
endproperty

PENABLE_PREADY : assert property (penable_pready) else `uvm_error("ASSERT","penable is not de-asserted after pready was asserted")

property psel_pen; 
	@(posedge pclk) disable iff (presetn)
	(psel && ~penable) |=> (psel && penable); // $rose(apb_if.penable)
endproperty

PSEL_PEN : assert property (psel_pen) else `uvm_error("ASSERT","penable is not asserted 1 cycle after psel")


endmodule : assertions
