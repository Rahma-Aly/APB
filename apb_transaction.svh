`ifndef APB_TRANSACTION_SVH
`define APB_TRANSACTION_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"
import apb_pkg::*;

class apb_transaction extends uvm_sequence_item;
	`uvm_object_utils(apb_transaction)

	logic 	     	pready;
	logic [31:0] 	prdata;	
	bit 	     	penable;
	bit 		presetn = 1;
	rand bit 	psel;
	rand bit 	pwrite;
	rand bit [addrWidth-1:0] paddr;
	rand bit [31:0] pwdata;

	function new (string name ="apb_trans");
		super.new(name);
	endfunction : new

	virtual function string convert2string();
		return $sformatf("PSEL = %0b, PENABLE = %0b, PWRITE = %0b, PADDR = %0b,PWDATA = %0b, PREADY = %0b, PRDATA = %0b ", psel,penable,pwrite,paddr,pwdata,pready,prdata);
	endfunction : convert2string	
endclass : apb_transaction

`endif
