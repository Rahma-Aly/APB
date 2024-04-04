interface apb_interface #(parameter addrWidth = 12);
	bit 	   pclk;
	bit 	   presetn;
	bit 	   psel;
	bit 	   penable;
	bit 	   pwrite;
	logic 	   pready;
	bit [addrWidth-1:0] paddr;
	bit [31:0] pwdata;
	logic[31:0]prdata;

	clocking cb_driver @(posedge pclk);
			default input #1step output #1;
			output presetn, psel, penable, pwrite, paddr, pwdata;
			input pready, prdata;
	endclocking

	clocking cb_monitor @(posedge pclk);
			default input #1step output #1;
			input presetn, psel, penable, pwrite, paddr, pwdata, pready, prdata;
	endclocking

endinterface
