`ifndef SEQ_SVH
`define SEQ_SVH

import uvm_pkg::*;
`include "uvm_macros.svh"
import apb_pkg::*;

class seq extends uvm_sequence;
	`uvm_object_utils(seq)
	apb_transaction m_trans;
	int n =200;

	function new(string name = "seq");
		super.new(name);
	endfunction : new

	virtual task body ();
		repeat(n) begin
			m_trans = apb_transaction::type_id::create("m_trans");
			start_item(m_trans);
			assert(m_trans.randomize());
			finish_item(m_trans);
		end
	endtask : body
endclass : seq


`endif 
