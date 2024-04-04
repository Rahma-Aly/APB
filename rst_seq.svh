`ifndef RST_SEQ_SVH
`define RST_SEQ_SVH
import uvm_pkg::*;
`include "uvm_macros.svh"
import apb_pkg::*;

class rst_seq extends uvm_sequence;
	`uvm_object_utils(rst_seq)
	apb_transaction m_trans;

	function new (string name = "rst_seq");
		super.new(name);
	endfunction:new 

	virtual task body ();
		m_trans = apb_transaction :: type_id::create("m_trans");
		start_item(m_trans);
		apply_rst();
		finish_item(m_trans);
	endtask : body

	virtual task apply_rst();//doesn't work as intended (1 -> 0 -> 1)
		m_trans.presetn <= 1'b1;
		#20;
		m_trans.presetn <= 1'b0;
		m_trans.psel <= 1'b0;
		m_trans.penable <= 1'b0;
		m_trans.pwrite <= 1'b0;
		m_trans.paddr <= 'b0;
		m_trans.pwdata <= 'b0;
		#50
		m_trans.presetn <= 1'b1;
	endtask : apply_rst




endclass : rst_seq
`endif
