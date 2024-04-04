`ifndef V_SEQ_SVH
`define V_SEQ_SVH
import uvm_pkg::*;
`include "uvm_macros.svh"
import apb_pkg::*;

class v_seq extends uvm_sequence;
	`uvm_object_utils(v_seq)
	rst_seq mr_seq;
	seq	m_seq;
	uvm_sequencer #(apb_transaction) m_sequencer;

	function new (string name = "rst_seq");
		super.new(name);
	endfunction:new 

	virtual task body ();
		m_seq = seq::type_id::create("m_seq");
		mr_seq = rst_seq::type_id::create("mr_seq");

		mr_seq.start(m_sequencer);
		#10;
		m_seq.start(m_sequencer);
		#100;

	endtask : body


endclass : v_seq

`endif

