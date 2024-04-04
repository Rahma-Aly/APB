`ifndef SCOREBOARD_SVH
`define SCOREBOARD_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"
import apb_pkg::*;

class scoreboard extends uvm_subscriber #(apb_transaction);
	`uvm_component_utils(scoreboard)
	apb_transaction m_trans;

	function new (string name = "scoreboard", uvm_component parent = null );
		super.new(name,parent);
	endfunction:new 

	virtual function void build_phase (uvm_phase phase);
		super.build_phase(phase);
       		m_trans = apb_transaction::type_id::create("m_trans");
	endfunction: build_phase

	virtual function void write (apb_transaction t);
		m_trans = t;
		`uvm_info("SCRBRD",$sformatf("transaction: %s",m_trans.convert2string()),UVM_NONE)
	endfunction : write

endclass : scoreboard	

`endif
